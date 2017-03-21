#!/bin/bash
consumed_mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
consumed_mem=$(echo $consumed_mem | awk '{print int($1)}')
total_mem=$(free -m | grep Mem | awk '{print $2}')
used_mem=$(free -m | grep Mem | awk '{print $3}')
echo "Total memory is $total_mem"MB
echo "Used memory is $used_mem"MB
echo "Percent of consumed memory is $consumed_mem"$
if [ "$consumed_mem" -gt 90 ]; then
  echo "Consumed memory is greater than 90%, rebooting machine..."
  /sbin/reboot
else
  echo "Consumed memory is less than 90%, machine is working normally"
  exit 0
fi
