#!/bin/bash

fpcBase=$1

if [ "$fpcBase" == "" ]; then
  echo "Need an FPC base to fpc sources"
  echo "Usually /usr/lib{32,64}/fpc/{fpc-version}/ on Linux machines."
  echo "or C:\FPC\..\.. on Windows machines."
  exit 255
fi
[ -f "Makefile" ] && rm Makefile
FPCDIR="$fpcBase" fpcmake

