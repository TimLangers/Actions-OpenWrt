#!/bin/bash

# 1. 移除 SmartDNS
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns

# 2. 强制补全关键依赖 (必须加入 luci-compat，否则插件会被静默移除)
{
    echo "CONFIG_PACKAGE_luci-compat=y"
    echo "CONFIG_PACKAGE_luci-app-openclash=y"
    echo "CONFIG_PACKAGE_luci-app-passwall=y"
    echo "CONFIG_PACKAGE_luci-theme-argon=y"
    echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y"
} >> .config

# 3. 通过 uci-defaults 强制设置默认值（在系统第一次启动时生效）
mkdir -p package/base-files/files/etc/uci-defaults
cat << "EOF" > package/base-files/files/etc/uci-defaults/99-custom-settings
#!/bin/sh
# 强制设为中文
uci set luci.main.lang=zh_cn
# 强制设为 Argon 主题
uci set luci.main.mediaurlbase=/luci-static/argon
uci commit luci
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings
