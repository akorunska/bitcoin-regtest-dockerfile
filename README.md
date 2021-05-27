## Running container:
```
docker build -t regtest-docker . 
docker run -i -t regtest-docker 
```


```
bitcoind -regtest > /dev/null &
bitcoin-cli -regtest getblockcount

bitcoin-cli -regtest createwallet "mywallet"
bitcoin-cli -regtest generatetoaddress 101 $(bitcoin-cli getnewaddress)

bitcoin-cli -regtest getbalances
bitcoin-cli -regtest getbalance
```