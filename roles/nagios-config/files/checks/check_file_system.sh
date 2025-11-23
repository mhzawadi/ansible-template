#!/bin/sh

NAGIOS_ERROR=3
NAGIOS_CRIT=2
NAGIOS_WARN=1
NAGIOS_OK=0

# =============================================================================
# arrange for cleanup should anything go wrong
cleanup(){
  echo "ERROR: cant update file system"
  exit $NAGIOS_CRIT
}
trap cleanup 1 2 3 6

# =============================================================================
#

if [ $(touch /mnt/lv_data/tmp) ]
then
  echo "CRITICAL - File has issues"
  echo $NAGIOS_CRIT
else
  if [ $(rm -f /mnt/lv_data/tmp) ]
  then
    echo "WARNING - File system is readonly"
    exit $NAGIOS_WARN
  fi
  echo "OK - File system is working"
  exit $NAGIOS_CRIT
fi
