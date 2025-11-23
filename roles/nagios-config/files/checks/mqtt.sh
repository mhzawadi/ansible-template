#!/bin/bash

. /home/nagios/.mqtt

if [ $# -lt 1 ]
then
  cat <<EOF
  This is an MQTT tool, you need to provide some options"
  $0 -t (arg) -m (arg) -s (arg) -c (arg)
  options:
    -s  sensor type (sensor/binary_sensor)
    -t  device class (https://www.home-assistant.io/integrations/binary_sensor/#device-class)

  $0 -t backups -m OFF -s binary_sensor -t problem
EOF
  exit 1
fi

MQTTCLIENT=$(hostname -f )
MQTTtopic="test"
MQTTsensor="sensor"
MQTTclass="date"
MQTTstatus="test"

while getopts "ht:s:m:c:" opt; do
  case $opt in
    h)
      print_usage
      ;;
    s)
      MQTTsensor=${OPTARG}
      ;;
    c)
      MQTTclass=${OPTARG}
      ;;
    t)
      MQTTtopic=$(echo ${OPTARG} | sed 's/ /-/g')
      ;;
    m)
      MQTTstatus="${OPTARG}"
      ;;
    *)
      print_usage
      exit 1
      ;;
  esac
done

# Config for date sensor
/usr/local/bin/mqttools publish \
  --retain \
  --host ${MQTTHOST} \
  --username ${MQTTUSER} \
  --password ${MQTT_KEY} \
  homeassistant/sensor/${MQTTCLIENT}-${MQTTtopic}-date/config \
  "{
  \"name\": \"${MQTTCLIENT} ${MQTTtopic} date\",
  \"device\": {
    \"identifiers\": \"${MQTTCLIENT}\",
    \"name\": \"${MQTTCLIENT}\",
    \"model\": \"${MQTTUSER} Hosting\",
    \"manufacturer\": \"${MQTTUSER}\"
  },
  \"stat_t\": \"~${MQTTtopic}/date\",
  \"uniq_id\": \"${MQTTCLIENT}-${MQTTtopic}-date\",
  \"~\": \"servers/$(hostname -f)/\",
  \"dev_cla\": \"date\",
  \"exp_aft\": 86400
}" 2>&1 > /dev/null

# config for status sensor
/usr/local/bin/mqttools publish \
  --retain \
  --host ${MQTTHOST} \
  --username ${MQTTUSER} \
  --password ${MQTT_KEY} \
  homeassistant/${MQTTsensor}/${MQTTCLIENT}-${MQTTtopic}-status/config \
  "{
  \"name\": \"${MQTTCLIENT} ${MQTTtopic} status\",
  \"device\": {
    \"identifiers\": \"${MQTTCLIENT}\",
    \"name\": \"${MQTTCLIENT}\",
    \"model\": \"${MQTTUSER} Hosting\",
    \"manufacturer\": \"${MQTTUSER}\"
  },
  \"stat_t\": \"~${MQTTtopic}/status\",
  \"uniq_id\": \"${MQTTCLIENT}-${MQTTtopic}-status\",
  \"~\": \"servers/$(hostname -f)/\",
  \"dev_cla\": \"${MQTTclass}\",
  \"exp_aft\": 86400
}" 2>&1 > /dev/null

/usr/local/bin/mqttools publish \
  --retain \
  --host ${MQTTHOST} \
  --username ${MQTTUSER} \
  --password ${MQTT_KEY} \
  servers/$(hostname -f)/${MQTTtopic}/date \
  "$(date --iso-8601=seconds)" 2>&1 > /dev/null

/usr/local/bin/mqttools publish \
  --retain \
  --host ${MQTTHOST} \
  --username ${MQTTUSER} \
  --password ${MQTT_KEY} \
  servers/$(hostname -f)/${MQTTtopic}/status \
  ${MQTTstatus} 2>&1 > /dev/null
