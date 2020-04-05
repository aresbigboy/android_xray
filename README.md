# v2ray_running_in_android_root


######################################################################################


android 系统的手机，如果具备ROOT环境（仅有adb shell 的 root权限 也可），便可使用此项目。

实现的效果为Android手机本身流量通过本地运行的v2ray进行分流代理（不区分数据流量或者WIFI流量）。

以及此Android手机分享出来的热点也具备科学上网能力。

######################################################################################


使用方法：

1、本项目全部文件下载到手机的 同一个目录内， 例如 /sdcard/Download/v2ray_running_in_android_root-master/  目录内。

目录内应至少包含的文件为 config.json.simple， return_ip-cn.sh， start_v2ray_and_iptables.sh， v2ray-linux-arm64




2、使用本机终端，或者adb shell下， 输入 su 回车，便可切到root权限。输入 cd /sdcard/Download/v2ray_running_in_android_root-master/ 进入工作目录。 执行 sh start_v2ray_and_iptables.sh 等待几分钟后出现 finished 提示，即代表执行完成。


3、如果想不重启手机清理v2ray进以及恢复iptables规则， 运行 sh clean_v2ray_and_iptables.sh 即可。

4、如果修改了 config.json.simple 这个配置文件后，想快速重启v2ray， 运行 sh reload_v2ray_config.sh 即可。

######################################################################################





PS:   
config.json.simple 是你的v2ray配置文件， 文件内的 outbound 根据你自己的v2ray配置进行修改（本项目使用的v2ray的tls+ws模式，根据文件内提示修改）。

脚本执行因为需要添加chinaip段，所以跑完大概需要5分钟，不要着急。等它自己跑完。看到 finished 算是成功，否则请查看脚本提示的报错信息。

如果看到finished 但手机无法访问外国网站（没有被墙的外国网站也无法访问），那一定是v2ray的配置文件有问题，导致没有翻墙成功。请仔细检查config.json.simple这个配置文件的内容。

另外，如果是手机终端运行的话可以输入 你在终端里可以这样执行    
su -c "sh /替换成你脚本放置的全路径/start_v2ray_and_iptables.sh"     例如: su -c "sh /storage/C2CB-1714/android_v2ray/start_v2ray_and_iptables.sh"    
这样就能直接以root权限运行这个脚本，并且可以把这条命令记录在你终端的history命令里，以后运行，就不需要su切root，然后再打那么多路径的英文了，直接按上方向键调出命令，回车运行即可。
