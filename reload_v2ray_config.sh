DIR_PATH="/data/data/v2ray-linux-arm64"
CONFIG_FILE="config.json.simple"
FILES_PATH="$(cd `dirname $0`; pwd)"
PID=$(ps -ef | grep "v2ray -config" | grep -vE "grep|$(echo $$)" | awk '{print $2}')

if [ ! -f ${FILES_PATH}/${CONFIG_FILE} ];then
    echo "V2RAY CONFIG FILE "${FILES_PATH}/${CONFIG_FILE}" not exist. now quit...."
    exit
fi

if [ -n "${PID}" ];then
    echo "V2RAY is running, then kill it...."
    kill -9 ${PID}
    sleep 2
else
    echo "V2RAY is Not Running, Try To Start It...."
fi

grep address ${FILES_PATH}/${CONFIG_FILE} | awk -F \" '{print $(NF-1)}' | \
while read VPSIP;do
    iptables -t nat -D V2RAY -d ${VPSIP} -j RETURN
    iptables -t nat -I V2RAY -d ${VPSIP} -j RETURN
done

############################################
echo "RUN V2RAY...."
nohup ${DIR_PATH}/v2ray -config=${FILES_PATH}/${CONFIG_FILE} > /dev/null 2>&1 &
if [[ $? -ne 0 ]];then
    echo "RUN V2RAY failed. now quit...."
    exit
fi


echo "Reload V2RAY Config finished...."
