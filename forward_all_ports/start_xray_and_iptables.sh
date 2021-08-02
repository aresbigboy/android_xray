DIR_PATH="/data/data/xray-linux-arm64"
FILES_PATH="$(cd `dirname $0`; pwd)"
CONFIG_FILE="$(cd $FILES_PATH && ls *config.json*)"

if [ ! -f ${FILES_PATH}/${CONFIG_FILE} ];then
    echo "XRAY CONFIG FILE "${FILES_PATH}/${CONFIG_FILE}" not exist. now quit...."
    exit
fi

if [ ! -f ${FILES_PATH}/return_ip-cn.sh ];then
    echo "${FILES_PATH}/return_ip-cn.sh not exist. WARNING!!!...."
fi

. ${FILES_PATH}/clean_xray_and_iptables.sh

############################################
echo "prepareing XRAY package to ${DIR_PATH}...."
mkdir -p ${DIR_PATH}
cp -arf ${FILES_PATH}/xray-linux-arm64/* ${DIR_PATH}/
if [[ $? -ne 0 ]];then
    echo "prepare XRAY package file. xray-linux-arm64.zip file or xray-linux-arm64 dir not exist. now quit...."
    exit
fi
chmod -R +x ${DIR_PATH}

############################################
echo "RUN XRAY...."
nohup ${DIR_PATH}/xray -config=${FILES_PATH}/${CONFIG_FILE} -format=json > /dev/null 2>&1 &
sleep 2
netstat -lnpt | grep "61099 "
if [ $? -ne 0 ];then
    echo "RUN XRAY failed. now quit...."
    exit
fi


############################################
echo "add iptables for XRAY rules...."

# 新建一个名为 XRAY 的链
iptables -w 3 -t nat -N XRAY

# 直连 内网网段
iptables -w 3 -t nat -A XRAY -d 0.0.0.0/8 -j RETURN
iptables -w 3 -t nat -A XRAY -d 10.0.0.0/8 -j RETURN
iptables -w 3 -t nat -A XRAY -d 127.0.0.0/8 -j RETURN
iptables -w 3 -t nat -A XRAY -d 169.254.0.0/16 -j RETURN
iptables -w 3 -t nat -A XRAY -d 172.16.0.0/12 -j RETURN
iptables -w 3 -t nat -A XRAY -d 192.168.0.0/16 -j RETURN
iptables -w 3 -t nat -A XRAY -d 224.0.0.0/4 -j RETURN
iptables -w 3 -t nat -A XRAY -d 240.0.0.0/4 -j RETURN

# 直连 VPS IP
grep address ${FILES_PATH}/${CONFIG_FILE} | awk -F \" '{print $(NF-1)}' | \
while read VPSIP;do
    iptables -w 3 -t nat -I XRAY -d ${VPSIP} -j RETURN;
done

# 直连 国IP段
echo "adding china ip rules please wait for minitus...."
sh ${FILES_PATH}/return_ip-cn.sh

# 其余流量转发到 61099 端口（即 V2Ray）
iptables -w 3 -t nat -A XRAY -p tcp -j REDIRECT --to-ports 61099

# 对局域网其他设备进行透明代理
iptables -w 3 -t nat -A PREROUTING -p tcp -j XRAY

# 对本机进行透明代理
iptables -w 3 -t nat -A OUTPUT -p tcp -j XRAY
#############################################

echo "add iptables for XRAY finished...."
