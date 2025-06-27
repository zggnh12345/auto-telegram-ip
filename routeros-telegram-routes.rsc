/ip route
:foreach i in=[find where comment~"telegram"] do={ remove $i }
add comment=ipv4-telegram-1 disabled=no distance=1 dst-address=91.105.192.0/23 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-2 disabled=no distance=1 dst-address=91.108.4.0/22 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-3 disabled=no distance=1 dst-address=91.108.8.0/21 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-4 disabled=no distance=1 dst-address=91.108.16.0/21 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-5 disabled=no distance=1 dst-address=91.108.56.0/22 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-6 disabled=no distance=1 dst-address=95.161.64.0/20 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-7 disabled=no distance=1 dst-address=149.154.160.0/20 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10
add comment=ipv4-telegram-8 disabled=no distance=1 dst-address=185.76.151.0/24 gateway=10.1.1.3 routing-table=main scope=30 target-scope=10

/ipv6 route
:foreach i in=[find where comment~"telegram"] do={ remove $i }
add comment=ipv6-telegram-1 disabled=no distance=1 dst-address=2001:67c:4e8::/48 gateway=fdac::3 routing-table=main scope=30 target-scope=10
add comment=ipv6-telegram-2 disabled=no distance=1 dst-address=2001:b28:f23c::/47 gateway=fdac::3 routing-table=main scope=30 target-scope=10
add comment=ipv6-telegram-3 disabled=no distance=1 dst-address=2001:b28:f23f::/48 gateway=fdac::3 routing-table=main scope=30 target-scope=10
add comment=ipv6-telegram-4 disabled=no distance=1 dst-address=2a0a:f280::/32 gateway=fdac::3 routing-table=main scope=30 target-scope=10
