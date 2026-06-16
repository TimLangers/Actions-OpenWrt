#!/bin/bash

# 1. 强力清理：删除可能干扰 feeds 的旧文件夹（防止之前 git clone 的残留干扰）
rm -rf package/luci-app-openclash
rm -rf package/luci-theme-argon
rm -rf package/luci-app-argon-config

# 2. 确保 feeds.conf.default 干净（可选：如果你想每次都重置）
# 如果你不想每次都重置，这行可以注释掉
# cp feeds.conf.default feeds.conf.default.bak

# 3. 添加基础 feeds (防止重复添加，加了简单的检查)
grep -q "github.com/openwrt/packages.git" feeds.conf.default || sed -i '$a src-git packages https://github.com/openwrt/packages.git' feeds.conf.default
grep -q "feed/routing.git" feeds.conf.default || sed -i '$a src-git routing https://git.openwrt.org/feed/routing.git' feeds.conf.default
grep -q "feed/telephony.git" feeds.conf.default || sed -i '$a src-git telephony https://git.openwrt.org/feed/telephony.git' feeds.conf.default
grep -q "github.com/openwrt/luci.git" feeds.conf.default || sed -i '$a src-git luci https://github.com/openwrt/luci.git' feeds.conf.default

# 4. 添加插件 feeds
grep -q "OpenClash" feeds.conf.default || sed -i '$a src-git openclash https://github.com/vernesong/OpenClash' feeds.conf.default
grep -q "luci-theme-argon" feeds.conf.default || sed -i '$a src-git argon https://github.com/jerrykuku/luci-theme-argon.git' feeds.conf.default
grep -q "luci-app-argon-config" feeds.conf.default || sed -i '$a src-git argon_config https://github.com/jerrykuku/luci-app-argon-config.git' feeds.conf.default

echo "==== diy-part1.sh finished successfully ===="
