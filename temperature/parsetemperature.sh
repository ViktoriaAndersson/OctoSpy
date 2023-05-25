#!/bin/bash
while :
do
  RAWTEMP=$(cat /sys/bus/w1/devices/28-00000e9547eb/w1_slave | grep "t=" | cut -d'=' -f2)
  TEMP=$(echo $RAWTEMP | awk '{print $1 / 1000}')
  echo "$(date +%s) $TEMP" > temperature.txt

  scp -P 2678 temperature.txt group16@quorkel.com:http/
  ssh -p 2678 group16@quorkel.com 'cat http/temperature.txt >> http/temperatures.txt'

  sleep 0.1
done
