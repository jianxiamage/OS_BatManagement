#!/bin/bash

host=$1

ping -c3 -i0.3 -W1 $host &>/dev/null
if [ $? -ne 0 ] ;then
  echo "[${host}] is DOWN!"
  exit 1
else
  echo "[${host}] is UP!"
fi
