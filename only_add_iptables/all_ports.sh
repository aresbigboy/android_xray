# 对局域网其他设备进行透明代理
iptables -w 3 -t nat -D PREROUTING -p tcp -j REDIRECT --to-ports 1099
iptables -w 3 -t nat -A PREROUTING -p tcp -j REDIRECT --to-ports 1099
