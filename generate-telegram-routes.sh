#!/usr/bin/env bash
set -euo pipefail

URL="https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/meta/geo/geoip/telegram.list"
OUT_FILE="routeros-telegram-routes.rsc"

GATEWAY4="10.1.1.3"
GATEWAY6="fdac::3"
TABLE="main"

curl -s "$URL" \
  | grep -E '^[0-9a-fA-F:.]+/[0-9]+' \
  | tee >(grep -v ':' > iplist4.txt) >(grep ':' > iplist6.txt) > /dev/null

{
  echo "/ip route"
  echo ":foreach i in=[find where comment~\"telegram-ip\"] do={ remove \$i }"
  COUNT4=0
  while read -r ip; do
    COUNT4=$((COUNT4 + 1))
    echo "add comment=telegram-ip-${COUNT4} disabled=no distance=1 dst-address=${ip} gateway=${GATEWAY4} routing-table=${TABLE} scope=30 target-scope=10"
  done < iplist4.txt

  echo ""
  echo "/ipv6 route"
  echo ":foreach i in=[find where comment~\"ipv6-telegram\"] do={ remove \$i }"
  COUNT6=0
  while read -r ip6; do
    COUNT6=$((COUNT6 + 1))
    echo "add comment=ipv6-telegram-${COUNT6} disabled=no distance=1 dst-address=${ip6} gateway=${GATEWAY6} routing-table=${TABLE} scope=30 target-scope=10"
  done < iplist6.txt
} > "$OUT_FILE"

rm -f iplist4.txt iplist6.txt
