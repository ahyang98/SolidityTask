//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    mapping (string => uint256) counts;
    mapping (string => bool) exists;
    string[] private candidates;
    constructor() {        
        init();
    }
    function init()  private {
        addCandidate("Alice");
        addCandidate("Bob");
        addCandidate("Charlie");
        
    }
    function addCandidate(string memory name) private {
        require(!exists[name], "Candidate already exists");
        counts[name] = 0;
        exists[name] = true;
        candidates.push(name);
    }

    function vote(string memory name)  public {        
        require(exists[name], "Candidate does not exist");
        counts[name] += 1;
    }
    function getVotes(string memory name) public view returns (uint) {
        return counts[name];
    }
    function resetVotes() public {
        for (uint i = 0; i < candidates.length; i++) {
            counts[candidates[i]] = 0;
        }
    }
}