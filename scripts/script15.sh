for i in `seq 0 3`; do
	echo 0 > /dev/rtled$i
	sleep 0.01
done
