# xray_running_in_android_root

把全部文件下载到你的手机本地路径，例如 /sdcard/Download/xray 内。
然后修改 config.json 配置文件 outbound 区域 对应自己的vps信息。

用termux 或者 adb shell  切换到 root用户后 运行 start_xray_and_iptables.sh 脚本即可。

执行过程只需要几秒钟。

PS：
1、重启手机后会恢复最初状态，需要从新运行 start脚本。

2、在不重启手机的前提下想要恢复原状，运行 clean开头的 那个脚本即可。

3、如果自己修改了配置文件，再次执行 start 那个脚本即可更新配置。
