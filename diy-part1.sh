#!/bin/bash
# ========================================================
# diy-part1.sh
# 此脚本在 OpenWrt 编译过程的第一步执行，用于添加外部依赖源
# ========================================================

# 1. 强制忽略 SSL 错误，防止国内网络拉取 Github 失败
export GIT_SSL_NO_VERIFY=true

# 2. 核心插件：PassWall (包含依赖库和应用本体)
echo 'src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' >> feeds.conf.default
echo 'src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall.git;main' >> feeds.conf.default

# 3. 核心插件：OpenClash
echo 'src-git openclash https://github.com/vernesong/OpenClash.git' >> feeds.conf.default

# 4. 界面主题：Argon (包含主题本体和配置模块)
# 确保使用 jerrykuku 的版本以兼容新版 OpenWrt
echo 'src-git argon https://github.com/jerrykuku/luci-theme-argon.git' >> feeds.conf.default
echo 'src-git argonconfig https://github.com/jerrykuku/luci-app-argon-config.git' >> feeds.conf.default

# 5. 更新并安装所有配置的源
# 这一步必须在 diy-part1 结束时完成，以便后续编译步骤能识别到这些包
./scripts/feeds update -a
./scripts/feeds install -a

echo "diy-part1.sh 执行完成：所有依赖源已成功添加并更新。"
