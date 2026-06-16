#!/bin/bash

# ========================================================
# diy-part1.sh（稳定版：避免 feed index 问题）
# ========================================================

export GIT_SSL_NO_VERIFY=true

echo "==== Cloning extra packages directly ===="

# OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/openclash

# Argon 主题
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# Argon 配置
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

echo "==== diy-part1 done ===="
