iptables-save | grep "\-\-to\-ports\ 61099$" | grep PREROUTING | sed 's/-A/iptables -t nat -D/g' | sh
