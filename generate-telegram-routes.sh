#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/telegram.list"
OUT_ROUTE_FILE="routeros-telegram-routes.rsc"
OUT_ADDRLIST_FILE="routeros-telegram-addresslist.rsc"
GATEWAY4="10.1.1.3"
GATEWAY6="fdac::3"
TABLE="main"

# 下载并校验
RAW=$(curl -fsSL "$URL" || { echo "[ERROR] 下载失败：$URL"; exit 1; })
IP_LIST=$(echo "$RAW" | grep -E '^[0-9a-fA-F:.]+/[0-9]+') || true
if [[ -z "$IP_LIST" ]]; then
  echo "[ERROR] 未匹配到任何 IP，可能是 GitHub 返回错误页面或内容格式改变"
  echo "$RAW" | head -n 10
  exit 1
fi

# 分离 IPv4 / IPv6
echo "$IP_LIST" | grep -v ':' > iplist4.txt
echo "$IP_LIST" | grep ':' > iplist6.txt

########################################
# 生成 routeros-telegram-routes.rsc
########################################
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
} > "$OUT_ROUTE_FILE"

########################################
# 生成 routeros-telegram-addresslist.rsc
########################################
{
  echo "/ip firewall address-list"
  echo ":foreach i in=[find where comment~\"telegram\"] do={ remove \$i }"
  COUNT4=0
  while read -r ip; do
    [[ -z "$ip" ]] && continue
    COUNT4=$((COUNT4 + 1))
    echo "add list=proxy_ipv4 address=${ip} comment=\"ipv4-telegram-${COUNT4}\""
  done < iplist4.txt

  echo ""
  echo "/ipv6 firewall address-list"
  echo ":foreach i in=[find where comment~\"telegram\"] do={ remove \$i }"
  COUNT6=0
  while read -r ip6; do
    [[ -z "$ip6" ]] && continue
    COUNT6=$((COUNT6 + 1))
    echo "add list=proxy_ipv6 address=${ip6} comment=\"ipv6-telegram-${COUNT6}\""
  done < iplist6.txt
} > "$OUT_ADDRLIST_FILE"

# 清理临时文件
rm -f iplist4.txt iplist6.txt

echo "[INFO] ✅ 已生成路由脚本：$OUT_ROUTE_FILE"
echo "[INFO] ✅ 已生成地址列表脚本：$OUT_ADDRLIST_FILE"
