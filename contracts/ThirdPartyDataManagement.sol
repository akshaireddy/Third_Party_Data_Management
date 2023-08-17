// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ThirdPartyDataManagement {
    struct DataRequest {
        address thirdParty;
        uint256 accessStartTime;
        uint256 accessEndTime;
        bool isActive;
    }

    mapping(address => DataRequest) public dataRequests;
    mapping(address => mapping(address => bool)) public dataAccess;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function requestAccess(address user, uint256 accessDuration) external {
        require(accessDuration > 0, "Access duration must be greater than 0");
        require(dataRequests[user].isActive == false, "A data request is already active");

        uint256 accessStartTime = block.timestamp;
        uint256 accessEndTime = accessStartTime + accessDuration;

        DataRequest memory newRequest = DataRequest({
            thirdParty: msg.sender,
            accessStartTime: accessStartTime,
            accessEndTime: accessEndTime,
            isActive: true
        });

        dataRequests[user] = newRequest;
    }

    function grantDataAccess(address user) external {
        DataRequest storage request = dataRequests[user];
        require(request.isActive, "No active data request for this user");
        require(request.thirdParty == msg.sender, "Only the requesting third party can access data");

        dataAccess[user][msg.sender] = true;
    }

    function revokeDataAccess(address thirdParty) external {
        require(dataAccess[msg.sender][thirdParty], "No access to revoke");
        dataAccess[msg.sender][thirdParty] = false;
    }

    function checkDataAccess(address user) external view returns (bool) {
        return dataAccess[user][msg.sender];
    }
}
