require('dotenv').config();
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  const contractAddress = process.env.CONTRACT_ADDRESS; // Read from environment variable
  const contract = new ethers.Contract(contractAddress, ["function checkDataAccess(address)"], deployer);

  const userAddress = process.env.USER_ADDRESS; // Read from environment variable
  const hasAccess = await contract.checkDataAccess(userAddress);

  console.log(`User has access: ${hasAccess}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
