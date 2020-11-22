FILES_PATH="$(cd `dirname $0`; pwd)"

if [[ $(iptables-save | grep V2RAY | grep -E "OUTPUT|PREROUTING" | wc -l) -ne 0 ]];then
    echo "found iptables for V2RAY. now clean OUTPUT PREROUTING rules...."
    iptables-save | grep V2RAY | grep -E "OUTPUT|PREROUTING" | sed 's/-A/iptables -t nat -D/g' | sh
else
    grep -E "OUTPUT|PREROUTING" ${FILES_PATH}/start_v2ray_and_iptables.sh | sh
fi
