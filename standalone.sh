#!/usr/bin/env bash

[[ -z $HOME ]] && HOME=/home/ubuntu
[[ -e /dev/rtled0 ]] || sudo insmod $HOME/raspigibbon_driver_installer/lib/4.1.19-v7+/rtled.ko && sudo chmod 666 /dev/rt*
[[ -e /dev/rtswitch0 ]] || sudo insmod $HOME/raspigibbon_driver_installer/lib/4.1.19-v7+/rtswitch.ko && sudo chmod 666 /dev/rt*

export GIBBON_STANDALONE_SCR_DIR=$HOME/raspigibbon_standalone
GIBBON_LED_NUM=0

inc()
{
	[[ $GIBBON_LED_NUM -eq 15 ]] && GIBBON_LED_NUM=0 || GIBBON_LED_NUM=$(($GIBBON_LED_NUM + 1))
	for i in `seq 0 3`; do
		printf "%04d\n" $(echo "obase=2;ibase=10;$GIBBON_LED_NUM" | bc) | rev | cut -c $(echo "$i+1" | bc) > /dev/rtled$i
	done
}

dec()
{
	[[ $GIBBON_LED_NUM -eq 0 ]] && GIBBON_LED_NUM=15 || GIBBON_LED_NUM=$(($GIBBON_LED_NUM - 1))
	for i in `seq 0 3`; do
		printf "%04d\n" $(echo "obase=2;ibase=10;$GIBBON_LED_NUM" | bc) | rev | cut -c $(($i+1)) > /dev/rtled$i
	done
}

flash()
{
	for i in `seq 0 3`; do
		echo 1 > /dev/rtled$i
	done
	sleep 0.15
	echo 0 | tee /dev/rtled* > /dev/null
	for i in `seq 0 3`; do
		printf "%04d\n" $(echo "obase=2;ibase=10;$GIBBON_LED_NUM" | bc) | rev | cut -c $(($i+1)) > /dev/rtled$i
	done
}

standalone()
{
	[[ $GIBBON_LED_NUM -eq 15 ]] && bash $GIBBON_STANDALONE_SCR_DIR/scripts/script15.sh && exit 0
	TARGET_FILE=$GIBBON_STANDALONE_SCR_DIR/scripts/script$GIBBON_LED_NUM.sh
	[[ -e $TARGET_FILE ]] && bash $TARGET_FILE
}

for i in `seq 0 3`; do
	echo 1 > /dev/rtled$i
	sleep 0.2
done
for i in `seq 0 3`; do
	echo 0 > /dev/rtled$i
	sleep 0.2
done
[[ $(cat /dev/rtswitch1) -eq 0 ]] && GIBBON=1
for i in `seq 0 3`; do
	echo 1 > /dev/rtled$i
	sleep 0.05
done
echo 0 | tee /dev/rtled* > /dev/null

if [[ $GIBBON -eq 1 ]]; then
	flash
	while : ; do
		[[ $(cat /dev/rtswitch2) -eq 0 ]] && inc
		[[ $(cat /dev/rtswitch0) -eq 0 ]] && dec
		[[ $(cat /dev/rtswitch1) -eq 0 ]] && flash && standalone && flash
		sleep 0.01
	done
fi

