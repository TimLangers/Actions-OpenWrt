#!/bin/bash
# 移除所有旧的配置，确保完全纯净
> feeds.conf.default

# 添加官方稳定源
echo "src-git packages https://git.openwrt.org/feed/packages.git" >> feeds.conf.default
echo "src-git routing https://git.openwrt.org/feed/routing.git" >> feeds.conf.default
echo "src-git telephony https://git.openwrt.org/feed/telephony.git" >> feeds.conf.default
echo "src-git luci https://git.openwrt.org/feed/luci.git" >> feeds.conf.default

# 添加插件
echo "src-git openclash https://github.com/vernesong/OpenClash" >> feeds.conf.default
# 暂时去掉 Argon，先确保基础编译通过
