pragma solidity ^0.5.0;

contract SocialNetwork {
    // state variable
    string public name;
    uint public postCount = 0;
    mapping(uint => Post) public posts;

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address payable author;
    }

    //constructor function
    constructor () public {
        name = "Aesthetic social network";
    }

    function createPost(string memory _content) public {
        //validity check
        require(bytes(_content).length > 0);
        // increment the post
        postCount++;
        //create the post
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        //trigger event
        emit PostCreated(postCount, _content, 0, msg.sender);
    }

    
}