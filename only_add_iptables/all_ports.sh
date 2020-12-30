# 对局域网其他设备进行透明代理
iptables-save | grep "\-\-to\-ports\ 1099$" | grep PREROUTING | sed 's/-A/iptables -t nat -D/g' | sh
iptables -t nat -A PREROUTING -p tcp -j REDIRECT --to-ports 1099
