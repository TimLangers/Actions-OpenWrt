#!/bin/bash

# 1. 强制清理：先移除所有已有的同名 feed 定义，防止重复
sed -i '/packages/d' feeds.conf.default
sed -i '/routing/d' feeds.conf.default
sed -i '/telephony/d' feeds.conf.default
sed -i '/luci/d' feeds.conf.default
sed -i '/openclash/d' feeds.conf.default
sed -i '/argon/d' feeds.conf.default

# 2. 重新添加基础 feeds
echo "src-git packages https://github.com/openwrt/packages.git" >> feeds.conf.default
echo "src-git routing https://git.openwrt.org/feed/routing.git" >> feeds.conf.default
echo "src-git telephony https://git.openwrt.org/feed/telephony.git" >> feeds.conf.default
echo "src-git luci https://github.com/openwrt/luci.git" >> feeds.conf.default

# 3. 添加自定义插件 feeds
echo "src-git openclash https://github.com/vernesong/OpenClash" >> feeds.conf.default
echo "src-git argon https://github.com/jerrykuku/luci-theme-argon.git" >> feeds.conf.default
echo "src-git argon_config https://github.com/jerrykuku/luci-app-argon-config.git" >> feeds.conf.default

echo "==== diy-part1.sh finished successfully ===="
