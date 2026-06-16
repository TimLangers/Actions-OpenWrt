#!/bin/bash
# ========================================================
# diy-part2.sh (已修复依赖缺失报错)
# ========================================================

# 1. 移除不必要的干扰（保留 bootstrap 主题以满足 luci-light 依赖，只移除不需要的应用）
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns

# 2. 强制补全核心依赖与应用配置
{
    echo "CONFIG_PACKAGE_luci-compat=y"
    echo "CONFIG_PACKAGE_luci-app-openclash=y"
    echo "CONFIG_PACKAGE_luci-app-passwall=y"
    echo "CONFIG_PACKAGE_luci-theme-argon=y"
    echo "CONFIG_PACKAGE_luci-app-argon-config=y"
    # 注意：确保语言包名称与你的固件版本匹配 (建议使用 zh-hans)
    echo "CONFIG_PACKAGE_luci-i18n-base-zh-hans=y"
    # 强制保留 bootstrap，防止编译中断
    echo "CONFIG_PACKAGE_luci-theme-bootstrap=y"
} >> .config

# 3. 创建 uci-defaults 脚本，在系统首次启动时自动切换为 Argon
mkdir -p package/base-files/files/etc/uci-defaults
cat << "EOF" > package/base-files/files/etc/uci-defaults/99-custom-settings
#!/bin/sh
# 强制设为简体中文
uci set luci.main.lang=zh-hans
# 强制设为 Argon 主题 (系统启动后自动切换，无需删除 bootstrap)
uci set luci.main.theme=argon
uci commit luci
exit 0
EOF

# 4. 赋予脚本执行权限
chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

# 5. 确保 feeds 中安装的主题被正确链接
./scripts/feeds install -a

echo "diy-part2.sh 执行完成：依赖已修复，Argon 将在启动时自动生效。"
