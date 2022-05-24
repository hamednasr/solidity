pragma solidity ^0.5.1;
contract Poll{
    address owner;
    struct Candidate{
        string name;
        uint votes;
    }
    Candidate[] candidates;
    mapping(address => bool) voters;

    constructor() public{
        owner = msg.sender;
        
    } 

    function addCandidate(string memory candidateName) public{
        require(msg.sender == owner);
        require(! isNameRepeated(candidateName));
        Candidate memory _candidate;
        _candidate.name = candidateName;
        _candidate.votes = 0;
        candidates.push(_candidate);
    }

    function equalstrings (string memory a, string memory b) 
    private pure returns(bool){
        if (bytes(a).length != bytes(b).length)
            return false;
        else
            for (uint i=0; i < bytes(a).length; i++){
                if (bytes(a)[i] != bytes(b)[i])
                    return false;
            }
            return true;
    }

    function isNameRepeated(string memory name) private view returns(bool){
        for (uint i; i < candidates.length; i++)
            if (equalstrings(candidates[i].name, name))
                return true;
        return false;
    }

    function showCandidates() public view returns(string memory){
        string memory str = '';
        for (uint i; i < candidates.length; i++){
            str = append(str, candidates[i].name);
            if (i < candidates.length - 1)
                str = append(str, ', ');
        }
        return str;
    }

    function append(string memory a, string memory b)
    private pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    function Vote(uint candidatenum) public{
        require(candidatenum>=0 && candidatenum < candidates.length, 'out of number of candidates');
        candidates[candidatenum].votes++;
    }

    function showVotes() public view returns(string memory){
        string memory str = '';
        for (uint i; i < candidates.length; i++){
            str = append(str, candidates[i].name);
            str = append(str,': ');
            str = append(str, uint2str(candidates[i].votes));
            if (i < candidates.length - 1)
                str = append(str, ', ');
        }
        return str;
    }

    function uint2str(uint _i) private pure returns (string memory _uintAsString) {
    if (_i == 0) {
        return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
        len++;
        j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
        bstr[k--] = byte(uint8(48 + _i % 10));
        _i /= 10;
    }
    return string(bstr);
}
}