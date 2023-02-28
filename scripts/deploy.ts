import { ethers } from "hardhat";

async function main() {
  const initialSupply = 1000;
  const contract = await ethers.getContractFactory("ClimateCoin");
  const climateCoin = await contract.deploy(initialSupply, "0x69015912AA33720b842dCD6aC059Ed623F28d9f7");

  await climateCoin.deployed();

  console.log("Climate Coin deployed to:", climateCoin.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
