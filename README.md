# Info

This is a fork of the original ClimateCoin contract which makes the contract compliant with the EIP2771 approach for gasless transactions. This was done as part of a workshop during Eth Denver 2023. Check out the frontend repository for this contract [here](https://github.com/Rahat-ch/zerotodapp_gasless_workshop)

# ClimateCoin

This is a Climate-focused project designed to rewards citizens with climate coin with carbon credits for climate change mitigation efforts. The goal is reduce the friction in Digital Monitorting, Review and Verification (D-MRV) by adding a registry for carbon credits and enabling on-chain rewards. This project seeks to demonstrate how D-MRV systems can be used to underpin future carbon markets under the goals
of the Paris Agreement by utilizing the smart contracts and reducing barriers to adoption. 

The use of blockchain technology to create immutable and auditable data and transfer records, including the creation of mitigation outcomes in digital form underpinned by smart contracts, is another important component of end-to-end digitalization of carbon markets that the industry requires.

To achieve this, the project contains a simple smart contract that achieves the following fuctions.

## Monitoring
A new farmer is registered by an administrator first. The administrator needs to indicate the total acerage of the farmer.

The farmer can then add a claim for consideration.

## Review & Verification

An admin can then verify pending submissions.

## Rewards
When an admin verifies a submission, ClimateCoin can then be allocated to participating farmers.


## Getting Started

Clone the repo and install dependencies

```shell
npm i
```

Create a .env file

```shell
cp .env-example .env;
```

Update .env to set your PRIVATE_KEY, ETHERSCAN_API_KEY, and POLYSCAN_API_KEY environment variables.


Try running some of the following tasks to compile and create contract.

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts --network mumbai
```

My climatecoin contract: https://mumbai.polygonscan.com/address/0x61c023fbd475a2a46aba79b5f72c83239bda2fd2


Update the command to use your contract address, then verify your contract

Note: We are supplying the Trusted Forwarder Contract address as the second argument for verification. 

```shell
npx hardhat verify --network mumbai <your-contract-address> 1000 0x69015912AA33720b842dCD6aC059Ed623F28d9f7
```

The result is your verified source code. Here's mine: https://mumbai.polygonscan.com/address/0x61c023fbd475a2a46aba79b5f72c83239bda2fd2#code
