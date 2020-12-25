# 对局域网其他设备进行透明代理
iptables -w 3 -t nat -D PREROUTING -p tcp -m multiport --dports 80,443,8080 -j REDIRECT --to-ports 1099
iptables -w 3 -t nat -A PREROUTING -p tcp -m multiport --dports 80,443,8080 -j REDIRECT --to-ports 1099
