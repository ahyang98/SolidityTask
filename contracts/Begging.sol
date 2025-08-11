//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BeggingContract {
    mapping (address => uint) donations;
    address public owner;
    uint256 public supply;
    uint256 private deployTimeStamp;
    uint256 private lockTime;
    address[3] private ranker;
    uint totalDonations;
    event donation(address indexed donor, uint256 amount);
    constructor(uint256 _lockTime) {
        owner = msg.sender;
        deployTimeStamp = block.timestamp;
        lockTime = _lockTime;
    }

    function donate() public payable windowOpening{
        require(msg.value > 0, "Donation must be greater than 0");
        if (donations[msg.sender] == 0) {
            totalDonations++;
        }
        donations[msg.sender] += msg.value;
        ranking(msg.sender);
    }

    function ranking(address _donor) private {
        for (uint i = 0; i < ranker.length; i++) {            
            if (ranker[i] == address(0)) {
                ranker[i] = _donor;
                return;
            } else if (donations[_donor] > donations[ranker[i]]) {
                for (uint j = ranker.length - 1; j > i; j--) {
                    ranker[j] = ranker[j - 1];
                }
                ranker[i] = _donor;
                return;
            }
        }

        if (totalDonations < 3) {
            for (uint i = ranker.length; i > 1; i--) {
                if (ranker[i-1] == ranker[i-2]) {
                    ranker[i-1] = address(0);
                    return;
                }
            }
        }
    }

    function getTop3() public view returns (address[3] memory) {
        return ranker;        
    }

    function withdraw() external onlyOwner{
        bool success;
        (success,) = payable(owner).call{value: address(this).balance}("");
        require(success, "withdraw failed");
        donations[owner] = 0;
        supply = 0;
    }
    
    function getDonation(address donor) external view returns (uint) {
        return donations[donor];
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "this function can only be called by owner");
        _;
    }

    modifier windowOpening() {
        require(block.timestamp < deployTimeStamp + lockTime, "window is closed");
        _;
        
    }
}