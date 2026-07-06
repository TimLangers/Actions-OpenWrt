#!/bin/bash

echo "==== applying clean system defaults ===="

mkdir -p package/base-files/files/etc/uci-defaults

cat > package/base-files/files/etc/uci-defaults/99-clean <<'EOF'
#!/bin/sh

# ===== 默认语言 =====
uci set luci.main.lang='zh_Hans'

# ===== 默认主题 =====
uci set luci.main.mediaurlbase='/luci-static/argon'

# 提交配置
uci commit luci

# 强力清理 LuCI 缓存与索引（确保首次登录直接应用中文和新主题）
rm -rf /tmp/luci-*
rm -rf /tmp/luci-indexcache

exit 0
EOF

chmod +x package/base-files/files/etc/uci-defaults/99-clean

echo "==== diy-part2.sh done ===="
