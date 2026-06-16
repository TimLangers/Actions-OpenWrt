#!/bin/bash
# ========================================================
# diy-part2.sh
# 此脚本在配置生成 (make defconfig) 前执行，用于清理、补全依赖和写入默认值
# ========================================================

# 1. 移除可能产生冲突的插件与主题
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/themes/luci-theme-bootstrap

# 2. 强制补全核心依赖与应用配置
# 确保 luci-compat 被加入，否则 Argon 主题及相关插件会失效
{
    echo "CONFIG_PACKAGE_luci-compat=y"
    echo "CONFIG_PACKAGE_luci-app-openclash=y"
    echo "CONFIG_PACKAGE_luci-app-passwall=y"
    echo "CONFIG_PACKAGE_luci-theme-argon=y"
    echo "CONFIG_PACKAGE_luci-app-argon-config=y"
    echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y"
} >> .config

# 3. 创建 uci-defaults 脚本，在系统首次启动时自动应用设置
# 这是确保界面语言和主题强制生效的最可靠方法
mkdir -p package/base-files/files/etc/uci-defaults
cat << "EOF" > package/base-files/files/etc/uci-defaults/99-custom-settings
#!/bin/sh
# 强制设为简体中文
uci set luci.main.lang=zh_cn
# 强制设为 Argon 主题
uci set luci.main.theme=argon
# 设定主题资源路径
uci set luci.main.mediaurlbase=/luci-static/argon
# 提交更改
uci commit luci
exit 0
EOF

# 4. 赋予脚本执行权限
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# 5. 确保 feeds 中安装的主题被正确链接
./scripts/feeds install -a

echo "diy-part2.sh 执行完成：配置已强制锁定，Argon 主题与中文设置已注入。"
