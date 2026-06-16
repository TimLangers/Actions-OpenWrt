#!/bin/bash

mkdir -p package/base-files/files/etc/uci-defaults

cat > package/base-files/files/etc/uci-defaults/99-custom-settings <<'EOF'
#!/bin/sh

# 默认中文（25.x 正确写法）
uci set luci.main.lang='zh_Hans'

# 默认 Argon 主题（关键修复）
uci set luci.main.mediaurlbase='/luci-static/argon'

uci commit luci

exit 0
EOF

chmod +x package/base-files/files/etc/uci-defaults/99-custom-settings

echo "uci defaults set"
