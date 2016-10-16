#!/bin/bash

#gksudo --sudo-mode
inst="Установить_TTL_вручную"
ans=$(zenity --list --text "Включение режима Yota через точку доступа с ttl=64?" --radiolist  --column "Номер" --column "Режим" TRUE Включить FALSE Выключить FALSE "$inst" );
#ttlrem=$(sudo iptables -t mangle -L --line-numbers | grep TTL | cut -c 1-2)
echo $ans
case $ans in
	Включить)
#		sudo iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set 65
		sudo echo "65" >  /proc/sys/net/ipv4/ip_default_ttl
		zenity --info --text "Значение TTL установлено в 65"
	;;

	Выключить)
#		if ( $ttlrem > 0 ); then
#		sudo iptables -t mangle -D POSTROUTING $ttlrem
#		fi
#		sudo iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set 64
		sudo echo "64" >  /proc/sys/net/ipv4/ip_default_ttl
		zenity --info --text "Значение TTL установлено в $64"
	;;

	$inst)
		ans=$(zenity --entry --text="Введите значение TTL вручную:");
sleep 3
#		sudo iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set $ans
		sudo echo $ans >  /proc/sys/net/ipv4/ip_default_ttl
		zenity --info --text "Значение TTL установлено в $ans"
	;;

	*)
	exit
	;;
	esac

echo " Значение TTL = $ans "
#iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set $ans
exit
