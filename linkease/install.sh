#! /bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export linkease`

mkdir -p $KSROOT/init.d
mkdir -p /tmp/upload

cd /tmp
cp -rf /tmp/linkease/bin/* $KSROOT/bin/
cp -rf /tmp/linkease/scripts/* $KSROOT/scripts/
cp -rf /tmp/linkease/init.d/* $KSROOT/init.d/
cp -rf /tmp/linkease/webs/* $KSROOT/webs/
cp /tmp/linkease/uninstall.sh $KSROOT/scripts/uninstall_linkease.sh

chmod +x $KSROOT/bin/link-ease
chmod +x $KSROOT/scripts/linkease_*
chmod +x $KSROOT/init.d/S99linkease.sh

# 为新安装文件赋予执行权限...
chmod 755 $KSROOT/scripts/linkease*

dbus set softcenter_module_linkease_description=强大易用的全平台共享工具
dbus set softcenter_module_linkease_install=1
dbus set softcenter_module_linkease_name=linkease
dbus set softcenter_module_linkease_title=LinkEase
dbus set softcenter_module_linkease_version=0.1

# make linkease restart/stop to apply change
sh /koolshare/scripts/linkease_config.sh

sleep 1
rm -rf /tmp/linkease* >/dev/null 2>&1
