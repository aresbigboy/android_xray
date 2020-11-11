PID=$(ps -ef | grep "v2ray -config" | grep -vE "grep|$(echo $$)" | awk '{print $2}')

if [ -n "${PID}" ];then
    echo "V2RAY is running, then kill it...."
    kill -9 ${PID}
    sleep 2
fi

if [[ $(iptables-save | grep V2RAY | wc -l) -ne 0 ]];then
    echo "found iptables for V2RAY. now clean rules...."
    iptables-save | grep V2RAY | grep -E "OUTPUT|PREROUTING" | sed 's/-A/iptables -t nat -D/g' | sh
    iptables -t nat -F V2RAY
    iptables -t nat -X V2RAY
fi
