// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";


contract ClimateCoin is ERC20, ERC2771Context  {
    mapping(address => bool) public isAnAdmin;
    mapping(address => bool) public isAFarmer;
    mapping(address => uint256) public acreage;
    mapping(address => bool) public claims;
    mapping(address => uint256) public rewards;
    mapping(address => bool) farmerWaitlist;

    event NewClaim(address indexed claimant);
    event ClaimApproved(address indexed farmer);
    event Rewarded(address indexed rewardee);
    event NewFarmer(address newFarmer);
    event NewAdminAdded(address sender);

    constructor(uint256 initialSupply, address trustedForwarder) 
        ERC20("ClimateToken", "CT")
        ERC2771Context(address(trustedForwarder)) {
        _mint(_msgSender(), initialSupply * decimals());
        isAnAdmin[_msgSender()] = true;
    }

    modifier onlyAdmins() {
        require(isAnAdmin[_msgSender()], "ClimateCoin:: Not an Admin");
        _;
    }

    function addClaim() public {
        require(isAFarmer[_msgSender()], "ClimateCoin:: Not a Farmer");
        claims[_msgSender()] = true;
        emit NewClaim(_msgSender());
    }

    function approveClaim(address _farmer) public onlyAdmins {
        require(claims[_farmer], "ClimateCoin:: No claims for Farmer");
        rewards[_farmer] = acreage[_farmer];
        emit ClaimApproved(_farmer);
    }

    function processRewards() public {
        require(rewards[_msgSender()] > 0, "ClimateCoin:: No rewards for farmer");
        uint256 totalRewards = rewards[_msgSender()] * decimals() * 4;
        rewards[_msgSender()] = 0;
        claims[_msgSender()] = false;
        _mint(_msgSender(), totalRewards);
        emit Rewarded(_msgSender());
    }

    function registerFarmer(address _farmer)
        public
    {
        farmerWaitlist[_farmer] = true;
    }

    function approveFarmer(address _farmer, uint256 _acerage)
        public
        onlyAdmins
    {
        farmerWaitlist[_farmer] = false;
        isAFarmer[_farmer] = true;
        acreage[_farmer] = _acerage;
        emit NewFarmer(_farmer);
    }

    function addAdmin(address _admin) public onlyAdmins {
        isAnAdmin[_admin] = true;
        emit NewAdminAdded(_admin);
    }

    /// @notice Overrides _msgSender() function from Context.sol
    /// @return address The current execution context's sender address
    function _msgSender() internal view override(Context, ERC2771Context) returns (address){
        return ERC2771Context._msgSender();
    }

    /// @notice Overrides _msgData() function from Context.sol
    /// @return address The current execution context's data
    function _msgData() internal view override(Context, ERC2771Context) returns (bytes calldata){
        return ERC2771Context._msgData();
    }
}
