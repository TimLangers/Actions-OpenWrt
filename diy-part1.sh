#!/bin/bash

# 彻底清空所有非默认的 feeds 定义，防止残留
sed -i '/src-git/d' feeds.conf.default

# 重新添加基础源（官方地址最稳定）
echo "src-git packages https://git.openwrt.org/feed/packages.git" >> feeds.conf.default
echo "src-git routing https://git.openwrt.org/feed/routing.git" >> feeds.conf.default
echo "src-git telephony https://git.openwrt.org/feed/telephony.git" >> feeds.conf.default
echo "src-git luci https://git.openwrt.org/feed/luci.git" >> feeds.conf.default

# 添加第三方插件
echo "src-git openclash https://github.com/vernesong/OpenClash" >> feeds.conf.default
echo "src-git argon https://github.com/jerrykuku/luci-theme-argon.git" >> feeds.conf.default
echo "src-git argon_config https://github.com/jerrykuku/luci-app-argon-config.git" >> feeds.conf.default

echo "==== diy-part1.sh finished successfully ===="
