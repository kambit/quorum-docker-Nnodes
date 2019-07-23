#!/bin/bash

#
# This is used at Container start up to run the constellation and geth nodes
#

set -u
set -e

### Configuration Options
TMCONF=/qdata/tm.conf

GETH_ARGS="--datadir /qdata/dd --raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --nodiscover --unlock 0 --raftport 50400 --password /qdata/passwords.txt --miner.gaslimit 18446744073709551615 --miner.gastarget 18446744073709551615 -verbosity 5"

if [ ! -d /qdata/dd/geth/chaindata ]; then
  echo "[*] Mining Genesis block"
  /usr/local/bin/geth --datadir /qdata/dd init /qdata/genesis.json
fi

echo "[*] Starting Constellation node"
nohup /usr/local/bin/constellation-node $TMCONF 2>> /qdata/logs/constellation.log &

sleep 2
DOWN=true
while $DOWN; do
  sleep 1
  DOWN=false
	if [ ! -S "/qdata/tm.ipc" ]; then
    DOWN=true
	fi
done

echo "[*] Starting node"
PRIVATE_CONFIG=/qdata/tm.ipc nohup /usr/local/bin/geth $GETH_ARGS 2>>/qdata/logs/geth.log
