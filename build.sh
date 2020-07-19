#!/bin/sh

MODULE="linkease"
VERSION="2.0"
TITLE="易有云2.0 - LinkEase"
DESCRIPTION="强大易用的全平台文件管理备份工具，支持双向同步！"
HOME_URL="Module_linkease.asp"
CHANGELOG="更新全新 2.0 版本"

# Check and include base
DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

# now include build_base.sh
. $DIR/../softcenter/build_base.sh

# change to module directory
cd $DIR

# do something here

do_build_result

sh backup.sh $MODULE
