#!/bin/bash

# 1. 确保基础 feeds 存在 (必须)
sed -i '$a src-git packages https://github.com/openwrt/packages.git' feeds.conf.default
sed -i '$a src-git routing https://git.openwrt.org/feed/routing.git' feeds.conf.default
sed -i '$a src-git telephony https://git.openwrt.org/feed/telephony.git' feeds.conf.default
sed -i '$a src-git luci https://github.com/openwrt/luci.git' feeds.conf.default

# 2. 以 feed 形式添加 OpenClash
sed -i '$a src-git openclash https://github.com/vernesong/OpenClash' feeds.conf.default

# 3. 如果是 Argon，建议放在 luci 目录下或者通过 feed 添加
# 示例：通过 feed 添加 (前提是该仓库支持)
sed -i '$a src-git argon https://github.com/jerrykuku/luci-theme-argon.git' feeds.conf.default

echo "==== diy-part1.sh finished successfully ===="
