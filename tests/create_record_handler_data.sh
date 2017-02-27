#!/bin/bash
if [ ! -f "RecordHandlerTest" ]; then
  echo " Run ./autogen.sh [fpc/unit/base] and then run make" 
  echo " and run this program again"
  exit 255;
fi
echo ""
seq 1 100 | while read i
do
echo -en "\r\033[K  Current Record : $i";
#./RecordHandlerTest
sleep 2 # Computer is to fast, need a delay.
done
