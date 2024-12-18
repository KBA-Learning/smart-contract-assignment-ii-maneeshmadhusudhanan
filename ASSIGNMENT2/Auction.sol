// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract SmartAuction {
    address SmartAdmin;
    address public owner;
    string Team;
    uint256 StartingPrice;

    constructor() {
        SmartAdmin = msg.sender;
    }

    modifier verify() {
        require(msg.sender == SmartAdmin, "Invalid access");
        _;
    }

    function setAuction(
        string memory _Team,
        uint256 _StartingPrice
    ) public verify {
        Team = _Team;
        StartingPrice = _StartingPrice;
        owner = msg.sender;
    }
    function displayAuction() public view returns (string memory, uint256) {
        return (Team, StartingPrice);
    }
    function auctionCall(uint256 Amount) public payable {
        if (Amount >= StartingPrice) {
            StartingPrice = Amount;
            owner = msg.sender;
        } else {
            payable(msg.sender).transfer(Amount);
        }
    }
}
