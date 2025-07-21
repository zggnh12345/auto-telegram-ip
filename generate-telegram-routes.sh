#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/telegram.list"
OUT_FILE="routeros-telegram-routes.rsc"
GATEWAY4="10.1.1.3"
GATEWAY6="fdac::3"
TABLE="main"

# 安全下载
RAW=$(curl -fsSL "$URL" || { echo "[ERROR] 下载失败：$URL"; exit 1; })

# 提取合法 IP
IP_LIST=$(echo "$RAW" | grep -E '^[0-9a-fA-F:.]+/[0-9]+') || true
if [[ -z "$IP_LIST" ]]; then
  echo "[ERROR] 未匹配到任何 IP，可能是 GitHub 返回错误页面或内容格式改变"
  echo "$RAW" | head -n 10
  exit 1
fi

# 安全分离 IPv4 / IPv6
echo "$IP_LIST" | grep -v ':' > iplist4.txt
echo "$IP_LIST" | grep ':' > iplist6.txt

# 生成 .rsc 脚本
{
  echo "/ip route"
  echo ":foreach i in=[find where comment~\"telegram\"] do={ remove \$i }"
  COUNT4=0
  while read -r ip; do
    [[ -z "$ip" ]] && continue
    COUNT4=$((COUNT4 + 1))
    echo "add comment=ipv4-telegram-${COUNT4} disabled=no distance=1 dst-address=${ip} gateway=${GATEWAY4} routing-table=${TABLE} scope=30 target-scope=10"
  done < iplist4.txt

  echo ""
  echo "/ipv6 route"
  echo ":foreach i in=[find where comment~\"telegram\"] do={ remove \$i }"
  COUNT6=0
  while read -r ip6; do
    [[ -z "$ip6" ]] && continue
    COUNT6=$((COUNT6 + 1))
    echo "add comment=ipv6-telegram-${COUNT6} disabled=no distance=1 dst-address=${ip6} gateway=${GATEWAY6} routing-table=${TABLE} scope=30 target-scope=10"
  done < iplist6.txt
} > "$OUT_FILE"

rm -f iplist4.txt iplist6.txt

echo "[INFO] 已生成 RouterOS 导入脚本：$OUT_FILE"
