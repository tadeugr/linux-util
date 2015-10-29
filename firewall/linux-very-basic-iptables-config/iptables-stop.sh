#!/bin/bash

# clear all chains
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
iptables -F -t filter
iptables -F POSTROUTING -t nat
iptables -F PREROUTING -t nat
iptables -F OUTPUT -t nat
iptables -F -t nat
iptables -t nat -F
iptables -t mangle -F
iptables -X

# clear all counters
iptables -Z
iptables -t nat -Z
iptables -t mangle -Z

# accept all by default
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

