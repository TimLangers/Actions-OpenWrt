#!/bin/bash

# 1. 清除所有重复/旧的源定义
sed -i '/src-git/d' feeds.conf.default

# 2. 必须的基础源
echo "src-git packages https://git.openwrt.org/feed/packages.git" >> feeds.conf.default
echo "src-git routing https://git.openwrt.org/feed/routing.git" >> feeds.conf.default
echo "src-git telephony https://git.openwrt.org/feed/telephony.git" >> feeds.conf.default
echo "src-git luci https://git.openwrt.org/feed/luci.git" >> feeds.conf.default

# 3. 添加 OpenClash
echo "src-git openclash https://github.com/vernesong/OpenClash" >> feeds.conf.default

# 4. 换用更兼容的 Argon 源 (注意：这里直接使用官方推荐或分支更稳定的地址)
# 如果你之前的地址有问题，请尝试换成下面的写法
echo "src-git luci_theme_argon https://github.com/jerrykuku/luci-theme-argon.git" >> feeds.conf.default
echo "src-git luci_app_argon_config https://github.com/jerrykuku/luci-app-argon-config.git" >> feeds.conf.default

echo "==== diy-part1.sh finished successfully ===="
