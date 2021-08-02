DIR_PATH="/data/data/xray-linux-arm64"
FILES_PATH="$(cd `dirname $0`; pwd)"
CONFIG_FILE="$(cd $FILES_PATH && ls *config.json*)"
PID=$(pgrep xray)

if [ ! -f ${FILES_PATH}/${CONFIG_FILE} ];then
    echo "XRAY CONFIG FILE "${FILES_PATH}/${CONFIG_FILE}" not exist. now quit...."
    exit
fi

if [ -n "${PID}" ];then
    echo "XRAY is running, then kill it...."
    kill -9 ${PID}
    sleep 2
else
    echo "XRAY is Not Running, Try To Start It...."
fi

grep address ${FILES_PATH}/${CONFIG_FILE} | awk -F \" '{print $(NF-1)}' | \
while read VPSIP;do
    iptables -t nat -D XRAY -d ${VPSIP} -j RETURN
    iptables -t nat -I XRAY -d ${VPSIP} -j RETURN
done

############################################
echo "RUN XRAY...."
nohup ${DIR_PATH}/xray -config=${FILES_PATH}/${CONFIG_FILE} -format=json > /dev/null 2>&1 &
sleep 2
netstat -lnpt | grep "61099 "
if [ $? -ne 0 ];then
    echo "RUN XRAY failed. now quit...."
    exit
fi


echo "Reload XRAY Config finished...."
