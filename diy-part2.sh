#!/bin/bash

# 1. 修改默认管理 IP
sed -i 's/192.168.1.1/10.1.1.1/g' package/base-files/files/bin/config_generate

# 2. 移除冲突插件 (SmartDNS)
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns

# 3. 通过 uci-defaults 强制设置中文和 Argon 主题 (最稳健方案)
mkdir -p package/base-files/files/etc/uci-defaults
cat << "EOF" > package/base-files/files/etc/uci-defaults/99-custom-settings
#!/bin/sh
# 设置默认语言为中文
uci set luci.main.lang=zh_cn
# 设置默认主题为 Argon
uci set luci.main.mediaurlbase=/luci-static/argon
uci commit luci
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# 4. 强制植入关键插件依赖 (防止编译时被忽略)
{
    echo "CONFIG_PACKAGE_luci-compat=y"
    echo "CONFIG_PACKAGE_luci-app-openclash=y"
    echo "CONFIG_PACKAGE_luci-app-passwall=y"
    echo "CONFIG_PACKAGE_luci-theme-argon=y"
    echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y"
} >> .config

# 5. 更新插件版本 (你的原逻辑保持不变)
# [此处插入你原本的 update_go_package 函数逻辑]
