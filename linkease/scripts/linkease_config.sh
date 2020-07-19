#!/bin/sh

source /koolshare/scripts/base.sh
eval `dbus export linkease_`

start_linkease(){
	token=`echo $linkease_token | sed s/[[:space:]]//g`
	start-stop-daemon -S -b -q -x $KSROOT/bin/link-ease >/dev/null
}

stop_linkease(){
	killall link-ease
}

creat_start_up(){
	[ ! -L "/etc/rc.d/S99linkease.sh" ] && ln -sf /koolshare/init.d/S99linkease.sh /etc/rc.d/S99linkease.sh
}

del_start_up(){
	rm -rf /etc/rc.d/S99linkease.sh >/dev/null 2>&1
}

open_port(){
	iptables -I zone_wan_input 2 -p tcp -m tcp --dport 8897 -m comment --comment "softcenter: linkease" -j ACCEPT >/dev/null 2>&1
}

close_port(){
	local port_exist=`iptables -L input_rule | grep -c linkease`
	if [ ! -z "$port_exist" ];then
		until [ "$port_exist" = 0 ]
	do
		iptables -D zone_wan_input -p tcp -m tcp --dport 8897 -m comment --comment "softcenter: linkease" -j ACCEPT >/dev/null 2>&1
		port_exist=`expr $port_exist - 1`
	done
	fi
}

write_nat_start(){
	uci -q batch <<-EOT
	  delete firewall.linkease
	  set firewall.linkease=include
	  set firewall.linkease.type=script
	  set firewall.linkease.path="/koolshare/scripts/linkease_nat.sh"
	  set firewall.linkease.family=any
	  set firewall.linkease.reload=1
	  commit firewall
	EOT
}

remove_nat_start(){
	uci -q batch <<-EOT
	  delete firewall.linkease
	  commit firewall
	EOT
}

case $1 in
port)
	open_port
	;;
*)
	if [ "$linkease_enable" == "1" ]; then
		stop_linkease
		sleep 1
		start_linkease
		creat_start_up
		open_port
		write_nat_start
		http_response '服务已开启！页面将在3秒后刷新'
	else
		stop_linkease
		del_start_up
		remove_nat_start
		http_response '服务已关闭！页面将在3秒后刷新'
	fi
	;;
esac
