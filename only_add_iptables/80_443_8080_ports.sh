# 对局域网其他设备进行透明代理

iptables-save | grep "\-\-to\-ports\ 61099$" | grep PREROUTING | sed 's/-A/iptables -t nat -D/g' | sh
iptables -t nat -A PREROUTING -p tcp -m multiport --dports 80,443,8080 -j REDIRECT --to-ports 61099
