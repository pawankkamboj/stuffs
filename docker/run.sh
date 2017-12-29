#!/bin/bash

bgp()
{
echo "setting up file quagga"

	if [ "$BGP_Self_ASN" ] && [ "$BGP_Self_ID" ] && [ "$BGP_External_Network" ] && [ "$BGP_PeerIP" ] && [ "BGP_Peer_ASN" ] 
	then
		sed -i -e "s|BGP_Self_ASN|$BGP_Self_ASN|g" -e "s|BGP_Self_ID|$BGP_Self_ID|g" -e "s|BGP_External_Network|$BGP_External_Network|g" -e "s|BGP_PeerIP|$BGP_PeerIP|g" -e "s|BGP_Peer_ASN|$BGP_Peer_ASN|g" /etc/quagga/bgpd.conf

	else
		echo "env variable are missing, please set following..."
		echo "BGP_Self_ASN - quagga instance ASN"
		echo "BGP_Self_ID - quagga instance IP"
		echo "BGP_External_Network - external network range"
		echo "BGP_PeerIP - BGP peer IP"
		echo "BGP_Peer_ASN - BGP peer ASN"
		exit 1
	fi

	echo "starting zebra"
	/usr/sbin/zebra -d -A 127.0.0.1 -f /etc/quagga/zebra.conf

	echo "starting bgpd"
	exec /usr/sbin/bgpd -A 127.0.0.1 -f /etc/quagga/bgpd.conf
}

#- run script
case "$1" in
bgp)
        bgp
        ;;
*)
        exec "$@"
        ;;
esac

