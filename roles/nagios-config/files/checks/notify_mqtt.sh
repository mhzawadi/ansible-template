#!/bin/sh

if [ "$1" == "UP" ]
then
  /usr/local/nagios/libexec/mqtt -t monitoring -m OFF -s binary_sensor -c problem
else
  /usr/local/nagios/libexec/mqtt -t monitoring -m ON -s binary_sensor -c problem
fi
