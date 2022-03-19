# xray_running_in_android_root

把全部文件下载到你的手机本地路径，例如 /sdcard/Download/xray 内。
然后修改 config.json 配置文件 outbound 区域 对应自己的vps信息。

用termux 或者 adb shell  切换到 root用户后 运行 start_xray_and_iptables.sh 脚本即可。

执行过程只需要几秒钟。

PS：

1. 重启手机后会恢复最初状态，需要从新运行 start脚本。

2. 在不重启手机的前提下想要恢复原状，运行 clean开头的 那个脚本即可。

3. 如果自己修改了配置文件，再次执行 start 那个脚本即可更新配置。


关于配置文件的修改或者生成，其实有个很简单的方法，在你现有的v2rayNG里的线路点击分享，然后选择第三项 **“导出完整配置至剪贴板”**，粘贴出来一个配置文件，命名规则遵循 “config.json.随便写” （例如：config.json.xtls) 。随后在inbound项添加如下配置即可。

```
   {
      "port": 61099,
      "protocol": "dokodemo-door",
      "settings": {
        "network": "tcp,udp",
        "followRedirect": true
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http","tls","fakedns"]
      }
   }, 
```


