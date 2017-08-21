#!/bin/bash

DELIMITER=","
MIB="/home/daniel/.snmp/mibs/UBNT-MIB.txt"

IP=$1
DEBUG=1
SNMPWALK="snmpwalk -Oqv -m ~/.snmp/mibs/UBNT-MIB.txt -v1 -c public"

WLSTAT="$SNMPWALK $IP ubntWlStatSignal"
STACOUNT="$SNMPWALK $IP ubntWlStatStaCount"
NOISEFL="$SNMPWALK $IP ubntWlStatNoiseFloor"
#ubntStaNoiseFloor
#ubntWlStatNoiseFloor
#rxPower0,1

# Cek IP
if [ -z "$IP" ]; then
	echo "Tidak ada alamat IP!"
	exit 1
fi

# Cek file MIB
if [[ $(ls "$MIB" | wc -l) != 1 ]]; then
	echo "Tidak menemukan file MIB. Simpan file MIB sebagai $MIB"
	exit 1
fi


while [[ true ]]; do
#snmpwalk -Oqv -m ~/.snmp/mibs/UBNT-MIB.txt -v1 -c public 192.168.1.40 ubntWlStatSignal
echo $(date +%Y%m%d%H%M%S)$DELIMITER$WLSTAT$DELIMITER$NOISEFL$STACOUNT
done
