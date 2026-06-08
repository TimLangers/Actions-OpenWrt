#!/bin/bash

# ==================== 1. 网络管理配置 ====================
# 修改默认管理 IP 为 10.1.1.1
sed -i 's/192.168.1.1/10.1.1.1/g' package/base-files/files/bin/config_generate

# ==================== 2. 界面与语言本地化 ====================
# 设置默认主题为 Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/modules/luci-base/root/etc/config/luci
# 设置默认语言为中文
sed -i "s/option lang 'auto'/option lang 'zh-cn'/" feeds/luci/modules/luci-base/root/etc/config/luci

# ==================== 3. 核心插件自动更新 (PassWall) ====================
update_go_package() {
    local pkg_name=$1
    local github_repo=$2
    local makefile_path="feeds/passwall_packages/$pkg_name/Makefile"
    [ -f "$makefile_path" ] || return 0
    
    local latest_version=$(curl --silent "https://api.github.com/repos/$github_repo/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')
    if [ -n "$latest_version" ]; then
        sed -i "s|PKG_VERSION:=.*|PKG_VERSION:=$latest_version|g" "$makefile_path"
        sed -i "s|PKG_HASH:=.*|PKG_HASH:=skip|g" "$makefile_path"
    fi
}

update_go_package "xray-core" "XTLS/Xray-core"
update_go_package "sing-box" "SagerNet/sing-box"
update_go_package "hysteria" "apernet/hysteria"

# ==================== 4. 强制启用核心组件 (关键修复) ====================
# 将 apk、luci 和温度监控直接写入配置文件，确保其优先级最高
{
    echo "CONFIG_PACKAGE_apk=y"
    echo "CONFIG_PACKAGE_luci=y"
    echo "CONFIG_PACKAGE_luci-mod-admin-full=y"
    echo "CONFIG_PACKAGE_luci-theme-argon=y"
    echo "CONFIG_PACKAGE_kmod-coretemp=y"
    echo "CONFIG_PACKAGE_kmod-it87=y"
    echo "CONFIG_PACKAGE_lm-sensors=y"
} >> .config

# 复制自定义温度显示模板
TARGET_INDEX="feeds/luci/modules/luci-mod-status/luasrc/view/admin_status/index.htm"
CUSTOM_SOURCE="$GITHUB_WORKSPACE/files/usr/lib/lua/luci/view/admin_status/index.htm"
[ -f "$CUSTOM_SOURCE" ] && cp -f "$CUSTOM_SOURCE" "$TARGET_INDEX"

# ==================== 5. 最终清理 ====================
# 移除会导致冲突的无用包
sed -i '/CONFIG_PACKAGE_onionshare-cli/d' .config
echo '# CONFIG_PACKAGE_onionshare-cli is not set' >> .config

# 注意：不要在此处执行 make defconfig，防止它覆盖你刚刚强行加入的 APK 配置
echo "✅ DIY-2.sh 脚本执行完毕"
