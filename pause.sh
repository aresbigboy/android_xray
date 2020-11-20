iptables-save | grep V2RAY | grep -E "OUTPUT|PREROUTING" | sed 's/-A/iptables -t nat -D/g' | sh
