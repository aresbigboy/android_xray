FILES_PATH="$(cd `dirname $0`; pwd)"

if [[ $(iptables-save | grep XRAY | grep -E "OUTPUT|PREROUTING" | wc -l) -ne 0 ]];then
    echo "Clear !!! Found iptables for XRAY. OUTPUT PREROUTING rules has been cleaned ...."
    iptables-save | grep XRAY | grep -E "OUTPUT|PREROUTING" | sed 's/-A/iptables -t nat -D/g' | sh
else
    grep -E "OUTPUT|PREROUTING" ${FILES_PATH}/start_xray_and_iptables.sh | sh
    echo "Added !!! Iptables Rules for XRAY. OUTPUT PREROUTING rules has been added ...."
fi
