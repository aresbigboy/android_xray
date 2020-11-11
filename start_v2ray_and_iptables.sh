DIR_PATH="/data/data/v2ray-linux-arm64"
CONFIG_FILE="config.json.simple"
FILES_PATH="$(cd `dirname $0`; pwd)"
PID=$(ps -ef | grep "v2ray -config" | grep -vE "grep|$(echo $$)" | awk '{print $2}')

if [ ! -f ${FILES_PATH}/${CONFIG_FILE} ];then
    echo "V2RAY CONFIG FILE "${FILES_PATH}/${CONFIG_FILE}" not exist. now quit...."
    exit
fi

if [ ! -f ${FILES_PATH}/return_ip-cn.sh ];then
    echo "${FILES_PATH}/return_ip-cn.sh not exist. WARNING!!!...."
fi

if [ -n "${PID}" ];then
    echo "V2RAY is running, then kill it...."
    kill -9 ${PID}
    sleep 2
fi

if [[ $(iptables-save | grep V2RAY | wc -l) -ne 0 ]];then
    echo "found iptables for V2RAY. now clean rules...."
    iptables -w 3 -t nat -D PREROUTING -p tcp -j V2RAY
    iptables -w 3 -t nat -D OUTPUT -p tcp -j V2RAY
    iptables -w 3 -t nat -F V2RAY
    iptables -w 3 -t nat -X V2RAY
fi

############################################
echo "prepareing V2RAY package to ${DIR_PATH}...."
mkdir -p ${DIR_PATH}
#unzip ${FILES_PATH}/v2ray-linux-arm64.zip -o -d ${DIR_PATH}/ || \
cp -ar ${FILES_PATH}/v2ray-linux-arm64/* ${DIR_PATH}/
if [[ $? -ne 0 ]];then
    echo "prepare V2RAY package file. v2ray-linux-arm64.zip file or v2ray-linux-arm64 dir not exist. now quit...."
    exit
fi
chmod -R +x ${DIR_PATH}

############################################
echo "RUN V2RAY...."
nohup ${DIR_PATH}/v2ray -config=${FILES_PATH}/${CONFIG_FILE} > /dev/null 2>&1 &
sleep 2
netstat -lnpt | grep "1099 "
if [ $? -ne 0 ];then
    echo "RUN V2RAY Failed. Now quit...."
    exit
fi


############################################
echo "add iptables for V2RAY rules...."

# 新建一个名为 V2RAY 的链
iptables -w 3 -t nat -N V2RAY

# 直连 内网网段
iptables -w 3 -t nat -A V2RAY -d 0.0.0.0/8 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 10.0.0.0/8 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 127.0.0.0/8 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 169.254.0.0/16 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 172.16.0.0/12 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 224.0.0.0/4 -j RETURN
iptables -w 3 -t nat -A V2RAY -d 240.0.0.0/4 -j RETURN

# 直连 VPS IP
grep address ${FILES_PATH}/${CONFIG_FILE} | awk -F \" '{print $(NF-1)}' | \
while read VPSIP;do
    iptables -w 3 -t nat -I V2RAY -d ${VPSIP} -j RETURN;
done

# 直连 国IP段
echo "adding china ip rules please wait for minitus...."
sh ${FILES_PATH}/return_ip-cn.sh &
while ((1));do
    echo -n "."
    sleep 1
    ps -ef | grep "return_ip-cn.sh" | grep -vE "grep|$$" > /dev/null 2>&1
    if [[ $? -eq 0 ]];then
        break
    fi
done

# V2ray 发出的流量 直连 (android seam to not support that....)
#iptables -w 3 -t nat -A V2RAY -p tcp -m mark --mark 0xff -j RETURN

# 其余流量转发到 1099 端口（即 V2Ray）
iptables -w 3 -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 1099

# 对局域网其他设备进行透明代理
iptables -w 3 -t nat -A PREROUTING -p tcp -j V2RAY

# 对本机进行透明代理
iptables -w 3 -t nat -A OUTPUT -p tcp -j V2RAY
#############################################

echo "add iptables for V2RAY finished...."
