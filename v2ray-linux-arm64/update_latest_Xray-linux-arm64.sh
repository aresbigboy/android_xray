#!/bin/bash

cd $(cd `dirname $0`; pwd)

curl -k -L -H "Cache-Control: no-cache" -o Xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-arm64-v8a.zip

unzip Xray.zip xray
chmod +x xray

rm -f Xray.zip v2ray
mv xray v2ray
