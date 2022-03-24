#!/bin/bash

cd $(cd `dirname $0`; pwd)

curl -k -L -H "Cache-Control: no-cache" -o Xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-android-arm64-v8a.zip $1

unzip -o Xray.zip xray geo*
rm -f Xray.zip
chmod +x xray
