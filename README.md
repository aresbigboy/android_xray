# v2ray_running_in_android_root


######################################################################################


android 系统的手机，如果具备ROOT环境（仅有adb shell 的 root权限 也可），便可使用此项目。

实现的效果为Android手机本身流量通过本地运行的v2ray进行分流代理（不区分数据流量或者WIFI流量）。

以及此Android手机分享出来的热点也具备科学上网能力。

######################################################################################


使用方法：

1、本项目全部文件下载到手机的 同一个目录内， 例如 /sdcard/Download/ 目录内。

应该包含的文件为 config.json.simple， return_ip-cn.sh， start_v2ray_and_iptables.sh， v2ray-linux-arm64.zip。

因为有些Android手机没有unzip命令，所以请将v2ray-linux-arm64文件夹 也放到到 同一个目录内 。



2、使用本机终端，或者adb shell，切到root权限后，执行 sh /sdcard/Download/start_v2ray_and_iptables.sh


3、如果想不重启手机清理v2ray进以及恢复iptables规则， 运行 sh /sdcard/Download/clean_v2ray_and_iptables.sh 即可。

4、如果修改了 /sdcard/Download/config.json.simple 这个配置文件后，想快速重启v2ray， 运行 sh /sdcard/Download/reload_v2ray_config.sh 即可。

######################################################################################





PS:   
config.json.simple 是你的v2ray配置文件， 文件内的 outbound 根据你自己的v2ray配置进行修改（本项目使用的v2ray的tls+ws模式，根据文件内提示修改）。

脚本执行因为需要添加chinaip段，所以跑完大概需要5分钟，不要着急。等它自己跑完。看到finished算是成功，否则请查看脚本提示的报错信息。

如果看到finished 但手机无法访问外国网站（没有被墙的外国网站也无法访问），那一定是v2ray的配置文件有问题，导致没有翻墙成功。请仔细检查config.json.simple这个配置文件的内容。
