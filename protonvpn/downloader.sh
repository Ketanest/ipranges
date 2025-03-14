#!/bin/bash

set -euo pipefail
set -x


# get from public ranges
curl -s https://api.protonvpn.ch/vpn/logicals > /tmp/protonvpn.json


# get all prefixes without some keys
jq '.LogicalServers[].Servers[].EntryIP' -r /tmp/protonvpn.json | tr -d '"' > /tmp/protonvpn-all.txt


# save ipv4
grep -v ':' /tmp/protonvpn-all.txt > /tmp/protonvpn-ipv4.txt

# ipv6 not provided


# sort & uniq
sort -V /tmp/protonvpn-ipv4.txt | uniq > protonvpn/ipv4.txt
