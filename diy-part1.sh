#!/bin/bash

# 1. 彻底清空现有的 feeds 配置，防止重复定义导致报错
> feeds.conf.default

# 2. 添加官方基础源，并显式指定与 OpenWrt 源码匹配的分支 (openwrt-25.12)
# 这一步是解决 "package does not exist" 警告的关键
echo "src-git packages https://github.com/openwrt/packages.git;openwrt-25.12" >> feeds.conf.default
echo "src-git routing https://git.openwrt.org/feed/routing.git;openwrt-25.12" >> feeds.conf.default
echo "src-git telephony https://git.openwrt.org/feed/telephony.git;openwrt-25.12" >> feeds.conf.default
echo "src-git luci https://github.com/openwrt/luci.git;openwrt-25.12" >> feeds.conf.default

# 3. 添加 OpenClash 源
echo "src-git openclash https://github.com/vernesong/OpenClash" >> feeds.conf.default

# 4. 针对 Argon 主题的特别处理：
# 由于 Argon 主题及其配置插件经常因为缺少 Makefile 索引报错，
# 如果使用下面这种方式依然报错，请在 diy-part2.sh 中改用 git clone 到 package/ 目录
echo "src-git luci_theme_argon https://github.com/jerrykuku/luci-theme-argon.git" >> feeds.conf.default
echo "src-git luci_app_argon_config https://github.com/jerrykuku/luci-app-argon-config.git" >> feeds.conf.default

echo "==== diy-part1.sh finished successfully ===="
