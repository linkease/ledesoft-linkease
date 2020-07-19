#!/bin/sh

alias echo_date1='echo $(date +%Y年%m月%d日\ %X)'
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

status=`pidof link-ease`
date=`echo_date1`


if [ -n "$status" ];then
	http_response "【$date】 LinkEase 进程运行正常！&nbsp;&nbsp;($status)"
else
	http_response "<font color='#FF0000'>LinkEase 进程未运行！</font>"
fi
