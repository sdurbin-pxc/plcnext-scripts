#!/bin/bash

DRIVER_PATH=/sys/class/signal_lamps/signal_lamps0/

led=""
mode=""
color=""
freq=""

shopt -s nocasematch

case "$2" in
 blink) mode=1;;
 on) mode=2;;
 off) mode=3;;
esac

case "$3" in
 green) color=1;;
 yellow) color=2;;
 red) color=3;;
esac

case "$1" in
 bf-c) led=0;;
 bf-d) led=1;;
 sf) led=2;;
 boot) led=3;;
 ext) led=4;;
 run) led=5;;
 fail) led=6;;
 dbg) led=7;;
 d) led=8;;
 e) led=9;;
esac

if [ "$led" = "" ]; then
	echo "invalid led name"
	exit
fi

if [ "$mode" != "" ]; then
	echo ${mode} > ${DRIVER_PATH}mode
	if [ "$mode" = 1 ] && [ $# -gt 3 ]; then
		echo $4 > ${DRIVER_PATH}period
	fi
fi

if [ "$color" != "" ]; then
	echo ${color} > ${DRIVER_PATH}colour
fi

echo ${led} > ${DRIVER_PATH}ledNumber

