# v2ray_running_in_android_root

android 系统的手机，如果具备ROOT环境（仅有adb shell 的 root权限 也可），便可使用此项目。

实现的效果为Android手机本身流量通过本地运行的v2ray进行分流代理（不区分数据流量或者WIFI流量）。

以及此Android手机分享出来的热点也具备科学上网能力。

使用方法：

1、本项目全部文件下载到手机的 /sdcard/Download/ 目录内。

应该包含的文件为 config.json.simple， return_ip-cn.sh， start_v2ray_and_iptables.sh， v2ray-linux-arm64.zip。

因为有些Android手机没有unzip命令，所以请另外手动解压v2ray-linux-arm64.zip文件 到 /sdcard/Download/v2ray-linux-arm64/内 。

/sdcard/Download/v2ray-linux-arm64/ 内的文件应该包括 v2ray , v2ctl 文件。


2、使用本机终端，或者adb shell，切到root权限后，执行 sh start_v2ray_and_iptables.sh


PS:   config.json.simple 是你的v2ray配置文件， 文件内的 outbound 根据你自己的v2ray配置进行修改（本项目使用的v2ray的ws模式，未配置tls，请注意）。
