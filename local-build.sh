#!/bin/sh

MODULE="linkease"
VERSION="2.1.1"
TITLE="易有云2.0 - LinkEase"
DESCRIPTION="多用户全平台文件管理工具，支持双向同步！"
HOME_URL="Module_linkease.asp"
CHANGELOG="更新全新 2.0 版本"

# Check and include base
rm -f ${MODULE}.tar.gz
#清理mac os 下文件
rm -f $MODULE/.DS_Store
rm -f $MODULE/*/.DS_Store

rm -f ${MODULE}.tar.gz
tar -zcvf ${MODULE}.tar.gz $MODULE
md5value=`md5sum ${MODULE}.tar.gz|tr " " "\n"|sed -n 1p`
cat > ./version <<EOF
$VERSION
$md5value
EOF
cat version

DATE=`date +%Y-%m-%d_%H:%M:%S`
cat > ./config.json.js <<EOF
{
"module":"$MODULE",
"version":"$VERSION",
"md5":"$md5value",
"home_url":"$HOME_URL",
"title":"$TITLE",
"description":"$DESCRIPTION",
"changelog":"$CHANGELOG",
"build_date":"$DATE"
}
EOF
