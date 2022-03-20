# 运行脚本后，xray进程跑在Android系统底层（不借助虚拟机，不借助任何框架，纯粹跑在Android底层）, 手机流量即可像挂客户端一样分流科学上网。
节省内存，节省电量，并且手机分享的热点亦可科学上网


- 使用方法
把全部文件下载到你的手机本地路径，例如 /sdcard/Download/xray 内。
然后修改 config.json 配置文件 outbound 区域 对应自己的vps信息。

用termux 或者 adb shell  切换到 root用户后 运行 start 脚本即可。

执行过程只需要几秒钟。

PS：

1. 重启手机后会恢复最初状态，需要从新运行 start脚本。
```
su -c "sh start"
```

2. 在不重启手机的前提下想要恢复原状，运行 stop 脚本即可。
```
su -c "sh stop"
```

3. 如果自己修改了配置文件，再次执行 start 那个脚本即可更新配置。

4. 因为Android底层运行，config.json 内使用域名连接vps可能有问题，请自行替换为vps的ip地址。


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

![选择导出完整配置](https://github.com/aresbigboy/download/blob/master/Screenshot_20220319-214300-787~2.png)

![添加箭头之间内容](https://github.com/aresbigboy/download/blob/master/Screenshot_20220319-214154-552~2.png)
