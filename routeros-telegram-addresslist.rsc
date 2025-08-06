/ip firewall address-list
add list=proxy_ipv4 address=91.105.192.0/23 comment="ipv4-telegram-1"
add list=proxy_ipv4 address=91.108.4.0/22 comment="ipv4-telegram-2"
add list=proxy_ipv4 address=91.108.8.0/21 comment="ipv4-telegram-3"
add list=proxy_ipv4 address=91.108.16.0/21 comment="ipv4-telegram-4"
add list=proxy_ipv4 address=91.108.56.0/22 comment="ipv4-telegram-5"
add list=proxy_ipv4 address=95.161.64.0/20 comment="ipv4-telegram-6"
add list=proxy_ipv4 address=149.154.160.0/20 comment="ipv4-telegram-7"
add list=proxy_ipv4 address=185.76.151.0/24 comment="ipv4-telegram-8"

/ipv6 firewall address-list
add list=proxy_ipv6 address=2001:67c:4e8::/48 comment="ipv6-telegram-1"
add list=proxy_ipv6 address=2001:b28:f23c::/47 comment="ipv6-telegram-2"
add list=proxy_ipv6 address=2001:b28:f23f::/48 comment="ipv6-telegram-3"
add list=proxy_ipv6 address=2a0a:f280::/32 comment="ipv6-telegram-4"
