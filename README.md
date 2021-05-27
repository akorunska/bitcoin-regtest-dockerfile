## Running container:
```
docker build -t regtest-docker . 
docker run -i -t regtest-docker 
```

## Running bitcoind and interacting with bitcoin-cli

Run bitcoin-cli in bg and check that it's accessible and runs correctly:
```
bitcoind -regtest > /dev/null &
bitcoin-cli -regtest getblockcount
```

Create wallet, generate some blocks and check balances:
```
bitcoin-cli -regtest createwallet "mywallet"
bitcoin-cli -regtest generatetoaddress 101 $(bitcoin-cli -regtest getnewaddress)

bitcoin-cli -regtest getbalances
bitcoin-cli -regtest getbalance
```

Explore blocks and transactions:
```
bitcoin-cli -regtest getbestblockhash
bitcoin-cli -regtest getblock <block>
bitcoin-cli -regtest getrawtransaction <trx>
bitcoin-cli -regtest decoderawtransaction <trx_data>
```

Stop regtest bitcoind:
```
bitcoin-cli -regtest stop
```