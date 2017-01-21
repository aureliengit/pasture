#!/bin/sh
#
# firewall-standalone.sh

IPT=/usr/sbin/iptables
MOD=/usr/sbin/modprobe
SYS=/usr/sbin/sysctl
SERVICE=/usr/sbin/service

# Réseau local
IFACE_LAN=enp2s0
IFACE_LAN_IP=192.168.2.0/24

# Tout accepter
$IPT -t filter -P INPUT ACCEPT
$IPT -t filter -P FORWARD ACCEPT
$IPT -t filter -P OUTPUT ACCEPT
$IPT -t nat -P PREROUTING ACCEPT
$IPT -t nat -P POSTROUTING ACCEPT
$IPT -t nat -P OUTPUT ACCEPT
$IPT -t mangle -P PREROUTING ACCEPT
$IPT -t mangle -P INPUT ACCEPT
$IPT -t mangle -P FORWARD ACCEPT
$IPT -t mangle -P OUTPUT ACCEPT
$IPT -t mangle -P POSTROUTING ACCEPT

# Remettre les compteurs à zéro
$IPT -t filter -Z
$IPT -t nat -Z
$IPT -t mangle -Z

# Supprimer toutes les règles actives et les chaînes personnalisées
$IPT -t filter -F
$IPT -t filter -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X

# Politique par défaut
$IPT -P INPUT DROP
$IPT -P OUTPUT ACCEPT

# Faire confiance à nous-mêmes ;o)
$IPT -A INPUT -i lo -j ACCEPT

# Ping
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT

# Connexions établies
$IPT -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# SSH 
$IPT -A INPUT -p tcp -i $IFACE_LAN --dport 22 -j ACCEPT

# Enregistrer les connexions refusées
$IPT -A INPUT -j LOG --log-prefix "+++ IPv4 packet rejected +++"
$IPT -A INPUT -j REJECT
  
# Enregistrer la configuration
$SERVICE iptables save
