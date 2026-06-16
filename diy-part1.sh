#!/bin/bash

export GIT_SSL_NO_VERIFY=true

# OpenClash
echo 'src-git openclash https://github.com/vernesong/OpenClash.git' >> feeds.conf.default

# Argon
echo 'src-git argon https://github.com/jerrykuku/luci-theme-argon.git' >> feeds.conf.default
echo 'src-git argonconfig https://github.com/jerrykuku/luci-app-argon-config.git' >> feeds.conf.default

echo "feed source added."
