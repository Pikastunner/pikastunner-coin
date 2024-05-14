// This script can be used to deploy the "Storage" contract using Web3 library.
// Please make sure to compile "./contracts/1_Storage.sol" file before running this script.
// And use Right click -> "Run" from context menu of the file to run the script. Shortcut: Ctrl+Shift+S

import { deploy } from './web3-lib'

(async () => {
  try {
    const result = await deploy('TokenExchange', ["ERC-20 Trade", "ERC-20", 18, 100000, 10, 10, 100])
    console.log(`address: ${result.address}`)
  } catch (e) {
    console.log(e.message)
  }
})()