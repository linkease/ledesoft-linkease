#! /bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval `dbus export linkease`

confs=`dbus list linkease|cut -d "=" -f1`

for conf in $confs
do
	dbus remove $conf
done

sleep 1
rm -rf $KSROOT/bin/link-ease
rm -rf $KSROOT/scripts/linkease*
rm -rf $KSROOT/init.d/S99linkease.sh
rm -rf /etc/rc.d/S99linkease.sh >/dev/null 2>&1
rm -rf $KSROOT/webs/Module_linkease.asp
rm -rf $KSROOT/webs/res/icon-linkease.png
rm -rf $KSROOT/webs/res/icon-linkease-bg.png

dbus remove softcenter_module_linkease_home_url
dbus remove softcenter_module_linkease_install
dbus remove softcenter_module_linkease_md5
dbus remove softcenter_module_linkease_version
dbus remove softcenter_module_linkease_name
dbus remove softcenter_module_linkease_description

