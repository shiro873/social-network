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

    event PostTipped(
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

    function tipPost(uint _id) public payable {
        // Fetch the post
        Post memory _post = posts[_id];
        // Fetch the author
        address payable _author = _post.author;
        // Pay the author by sending them Ether
        address(_author).transfer(msg.value);
        // Increment the tip amount
        _post.tipAmount = _post.tipAmount + msg.value;
        // Update the post
        posts[_id] = _post;
        // Trigger an event
        emit PostTipped(postCount, _post.content, _post.tipAmount, _author);
    }
}