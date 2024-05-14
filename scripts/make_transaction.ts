import { ethers } from 'ethers';

export const accessContract = async (contractAddress: string, contractName: string): Promise<ethers.Contract> => {    
    const artifactsPath = `browser/contracts/artifacts/${contractName}.json` // Change this for different path
    const abi = JSON.parse(await remix.call('fileManager', 'getFile', artifactsPath)).abi;
    const provider = new ethers.providers.Web3Provider(web3Provider);
    const contract = new ethers.Contract(contractAddress, abi, provider);

    return contract
}

// Replace with your contract address and ABI
const contractAddress = '0x2a6C8bf0576BAcc215e647B1fE569aE96FDB328A';
const contractName = 'TokenExchange';

(async () => {
  try {
    const contract = await accessContract(contractAddress, contractName)
    const returnedString = await contract.print();
    console.log(returnedString); // Output: "Hello World!"
    console.log('Print successfully');
  } catch (e) {
    console.log(e.message)
  }
})()


