#!/bin/bash
inst="Установить_TTL_вручную"
ans=$(zenity --list --text "Включение режима Yota через точку доступа с ttl=64?" --radiolist  --column "Номер" --column "Режим" TRUE Включить FALSE Выключить FALSE "$inst" );
echo $ans
case $ans in
	Включить)
		(iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set 65) | zenity --progress --pulsate --title="Установка TTL в iptables" --text="Прогресс"
		zenity --info --text "Значение TTL установлено в 65"
	;;

	Выключить)
		(iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set 64) | zenity --progress --pulsate --title="Установка TTL в iptables" --text="Прогресс"
		zenity --info --text "Значение TTL установлено в $64"
	;;

	$inst)
		ans=$(zenity --entry --text="Введите значение TTL вручную:");
sleep 3
#		(iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set $ans) | zenity --progress --pulsate --title="Установка TTL в iptables" --text="Прогресс"
		zenity --info --text "Значение TTL установлено в $ans"
	;;

	*)
	exit
	;;
	esac

echo " Значение TTL = $ans "
#iptables -t mangle -A PREROUTING -o eth0 -j TTL --ttl-set $ans
exit

