#!/bin/sh

var=`grep "\sro[\s,]" /proc/mounts  | grep -v -e "tmpfs"`
if [ "$var" != "" ]
then
        echo "CRITICAL! the system is readonly"
        exit 2
else
        echo "OK - The system is read write"
        exit 0
fi
