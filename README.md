# World House
A solidity game of builing house on ethereum.

## development env
* node: v16.20.0
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
* connect private network on metamask
  ```
  # metamask config:
  1. chain id: 1337
  2. rpc url: http://127.0.0.1:9545
  3. import truffle account into metamask
  4. choose the imported account and the private network on metamask
  ```
* start dev server:
  ```
  yarn dev
  ```
* start dev client:
  ```
  yarn watch
  ```
* open webpage: http://localhost

## build 
* build frontend app
  ```
  yarn build
  ```
* then start the server
  ```
  yarn serve
  ```

## web3 and contract apis
* [web3js](https://web3js.readthedocs.io/en/v1.4.0/web3-eth.html)
* [truffle contract](https://github.com/trufflesuite/truffle/tree/master/packages/contract)

## common error
* when the contract was not deployed:
  ```
  Error: Returned values aren't valid, did it run Out of Gas?
  ```
  just run migrate in truffle develop, make sure contract is deployed.
* when metamask transation stuck, just reinstall metamask, reimport accounts