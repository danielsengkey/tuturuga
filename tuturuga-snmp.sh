#!/bin/bash

DELIMITER=","
MIB="/home/daniel/.snmp/mibs/UBNT-MIB.txt"

IP=$1
DEBUG=1
SNMPWALK="snmpwalk -Oqv -m ~/.snmp/mibs/UBNT-MIB.txt -v1 -c public"

WLSTAT="$SNMPWALK $IP ubntWlStatSignal"
RSSI="$SNMPWALK $IP ubntWlStatRssi"
DIST="$SNMPWALK $IP radioLinkDistM"
STACOUNT="$SNMPWALK $IP ubntWlStatStaCount"
NOISEFL="$SNMPWALK $IP ubntWlStatNoiseFloor"
CHAIN0="$SNMPWALK $IP rxPower0"
CHAIN1="$SNMPWALK $IP rxPower1"

#ubntStaNoiseFloor
#ubntWlStatNoiseFloor
#rxPower0,1
#radioLinkDistM
#date +%Y%m%d%H%M%S

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

get_date(){
	date +%F
}
get_time(){
	date +%T:%N
}
get_epoch(){
	date +%s
}

clear
echo "OUTPUT:"
echo "Date $DELIMITER Time $DELIMITER Timestamp (Epoch) $DELIMITER Signal $DELIMITER RSSI $DELIMITER Noise Floor $DELIMITER Rx Chain 0 $DELIMITER Rx Chain 1 $DELIMITER Approx. Distance" 

while [[ true ]]; do
#snmpwalk -Oqv -m ~/.snmp/mibs/UBNT-MIB.txt -v1 -c public 192.168.1.40 ubntWlStatSignal
	if [ $DEBUG==1 ]; then
		echo -n $(get_date)$DELIMITER
		echo -n $(get_time)$DELIMITER
		echo -n $(get_epoch)$DELIMITER
		echo -n $WLSTAT$DELIMITER
		echo -n $RSSI$DELIMITER
		echo -n $NOISEFL$DELIMITER
		echo -n $CHAIN0$DELIMITER
		echo -n $CHAIN1$DELIMITER
		echo $DIST
	else
		echo -n $(get_date)$DELIMITER
		echo -n $(get_time)$DELIMITER
		echo -n $(get_epoch)$DELIMITER
		echo -n $(eval $WLSTAT)$DELIMITER
		echo -n $(eval $RSSI)$DELIMITER
		echo -n $(eval $NOISEFL)$DELIMITER
		echo -n $(eval $CHAIN0)$DELIMITER
		echo -n $(eval $CHAIN1)$DELIMITER
		echo $(eval $DIST)
	fi
done
