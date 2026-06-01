/ip firewall address-list
:foreach i in=[find where comment~"telegram"] do={ remove $i }
add list=proxy_ipv4 address=91.105.192.0/23 comment="telegram_ipv4_1"
add list=proxy_ipv4 address=91.108.4.0/22 comment="telegram_ipv4_2"
add list=proxy_ipv4 address=91.108.8.0/21 comment="telegram_ipv4_3"
add list=proxy_ipv4 address=91.108.16.0/21 comment="telegram_ipv4_4"
add list=proxy_ipv4 address=91.108.56.0/22 comment="telegram_ipv4_5"
add list=proxy_ipv4 address=95.161.64.0/20 comment="telegram_ipv4_6"
add list=proxy_ipv4 address=149.154.160.0/20 comment="telegram_ipv4_7"
add list=proxy_ipv4 address=185.76.151.0/24 comment="telegram_ipv4_8"

/ipv6 firewall address-list
:foreach i in=[find where comment~"telegram"] do={ remove $i }
add list=proxy_ipv6 address=2001:67c:4e8::/48 comment="telegram_ipv6_1"
add list=proxy_ipv6 address=2001:b28:f23c::/47 comment="telegram_ipv6_2"
add list=proxy_ipv6 address=2001:b28:f23f::/48 comment="telegram_ipv6_3"
add list=proxy_ipv6 address=2a0a:f280::/32 comment="telegram_ipv6_4"
