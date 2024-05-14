pragma solidity >=0.4.22 <0.9.0;

contract Voting {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        bool hasVoted;
    }

    mapping (uint256 => Candidate) public candidates;

    //public variable
    uint256 public candidateCount;

    function addCandidate(string memory _name) public {
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0, false);
    }

    function voteCandidate(uint256 candidateIndex, uint256 voterIndex) public
    {
        if(candidates[voterIndex].hasVoted != true)
        {
            candidates[candidateIndex].voteCount++;
            candidates[voterIndex].hasVoted = true;
        }
    }

    function getWinner() public view returns (string memory) { //string is an array of character (including 'bytes') need to specify location where the data is stored.
        //require in solidity used for validation purposes. syntax(condition, output)
        require(candidateCount > 0, "No candidates registered");

        uint256 maxVotes = 0;
        uint256 winnerId;

        // Iterate through all candidates to find the one with the most votes
        for (uint256 i = 1; i <= candidateCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerId = i;
            }
        }

        // Return the name of the winner
        return candidates[winnerId].name;
    }
}