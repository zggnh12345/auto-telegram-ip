/ip route
:foreach i in=[find where comment~"telegram"] do={ remove $i }

/ipv6 route
:foreach i in=[find where comment~"telegram"] do={ remove $i }
add comment=ipv6-telegram-1 disabled=no distance=1 dst-address=2001:67c:4e8::/48 gateway=fdac::3 routing-table=main scope=30 target-scope=10
add comment=ipv6-telegram-2 disabled=no distance=1 dst-address=2001:b28:f23c::/47 gateway=fdac::3 routing-table=main scope=30 target-scope=10
add comment=ipv6-telegram-3 disabled=no distance=1 dst-address=2001:b28:f23f::/48 gateway=fdac::3 routing-table=main scope=30 target-scope=10
add comment=ipv6-telegram-4 disabled=no distance=1 dst-address=2a0a:f280::/32 gateway=fdac::3 routing-table=main scope=30 target-scope=10
