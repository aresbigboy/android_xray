iptables-save | grep "\-\-to\-ports\ 1099$" | grep PREROUTING | sed 's/-A/iptables -t nat -D/g' | sh
