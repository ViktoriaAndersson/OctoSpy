#!/bin/bash


while

  SAMPLE=$(cat /dev/ttyS0 | grep -m 1 GNGGA)

  LATRAW=$(echo $SAMPLE | cut -d ',' -f 3)
  LATMIN=$(echo $LATRAW | cut -c 1-2)
  LATFRACTION=$(echo $LATRAW | cut -c 3-)
  LATDECIMAL=$(echo "scale=10; $LATFRACTION / 60" | bc)

  echo $SAMPLE
  echo $LATMIN
  echo $LATFRACTION
  echo $LATDECIMAL
  echo $LATMIN$LATDECIMAL


  scp

  sleep 1

end
