#!/bin/bash

echo "==== applying clean system defaults ===="

mkdir -p package/base-files/files/etc/uci-defaults

cat > package/base-files/files/etc/uci-defaults/99-clean <<'EOF'
#!/bin/sh

# ===== language =====
uci set luci.main.lang='zh_Hans'

# ===== theme =====
uci set luci.main.mediaurlbase='/luci-static/argon'
uci set luci.main.media='/luci-static/argon'

uci commit luci

# 清 LuCI 缓存（防止首次英文）
rm -rf /tmp/luci-*

exit 0
EOF

chmod +x package/base-files/files/etc/uci-defaults/99-clean

echo "==== diy-part2 done ===="
