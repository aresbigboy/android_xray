PID=$(pgrep xray)

if [ -n "${PID}" ];then
    echo "XRAY is running, then kill it...."
    kill -9 ${PID}
    sleep 2
fi

if [[ $(iptables-save | grep XRAY | wc -l) -ne 0 ]];then
    echo "found iptables for XRAY. now clean rules...."
    iptables-save | grep XRAY | grep -E "OUTPUT|PREROUTING" | sed 's/-A/iptables -t nat -D/g' | sh
    iptables -t nat -F XRAY
    iptables -t nat -X XRAY
fi
