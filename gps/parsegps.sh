#!/bin/bash


while :
do
  SAMPLE=$(cat /dev/ttyS0 | grep -m 1 GNGGA)

  LATRAW=$(echo $SAMPLE | cut -d ',' -f 3)
  LATMIN=$(echo $LATRAW | cut -c 1-2)
  LATFRACTION=$(echo $LATRAW | cut -c 3-)
  LATDECIMAL=$(echo "scale=10; $LATFRACTION / 60" | bc)


  LONGRAW=$(echo $SAMPLE | cut -d ',' -f 5)
  LONGMIN=$(echo $LONGRAW | cut -c 1-3)
  LONGFRACTION=$(echo $LONGRAW | cut -c 3-)
  LONGDECIMAL=$(echo "scale=10; $LONGFRACTION / 60" | bc)

  echo "$(date +%s) $LATMIN$LATDECIMAL $LONGMIN$LONGDECIMAL" > coordinate.txt
	
  scp -P 2678 coordinate.txt group16@quorkel.com:http/
  ssh -p 2678 group16@quorkel.com 'cat http/coordinate.txt >> http/coordinates.txt'

  sleep 0.1

done
