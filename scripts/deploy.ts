import { ethers } from "hardhat";
// const { ethers } = require("hardhat");

async function main() {
  const ThirdPartyDataManagement = await ethers.getContractFactory("ThirdPartyDataManagement");
  const contract = await ThirdPartyDataManagement.deploy();

  console.log("Contract deployed to address:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
