# World House
A solidity game about builing house on ethereum.

## development env
* node: v10.24.1
* truffle
* Metamask browser extension

## development
* start truffle blockchain
```
# start truffle node:
truffle develop
# deploy contract, on truffle console, run:
migrate
```
* connect private network on matamask, with chain id 1337, rpc url http://127.0.0.1:9545

* start dev server:
  ```
  yarn dev
  ```
* start dev client:
  ```
  yarn cdev
  ```
* open webpage: http://localhost

## build 
* build frontend app
```
yarn cbuild
```
* start server
```
yarn start
```
* open webpage: http://localhost

## web3 and contract apis
* [web3js](https://web3js.readthedocs.io/en/v1.4.0/web3-eth.html)
* [truffle contract](https://github.com/trufflesuite/truffle/tree/master/packages/contract)