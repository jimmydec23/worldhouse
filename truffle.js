module.exports = {
  networks: {
    // when running truffle develop
    develop:{
      host: "127.0.0.1",
      port: 9545,
      network_id: 5777,
    },
    rinkeby: {
      host: "127.0.0.1", // Connect to geth on the specified
      port: 8545,
      from: "0x40e4472789aa2b93770cedc18576703509a17407", // default address to use for any transaction Truffle makes during migrations
      network_id: 4,
      gas: 4612388 // Gas limit used for deploys
    }
  },
  compilers: {
    solc: {
      version: "0.8.9"
    }
  }
}