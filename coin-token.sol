pragma  solidity ^0.8.4;

//The contract allows only its creator to create new  coin (different issuance schema are possible).
//Anyone can send coins to each other without a need for registering with  a username and password, all you need is a an ethereum keypair.


contract Coin {
    // key word public its making the  state variables
    //here accessible   from other contracts
    address public minter;
    mapping (address => uint) public balances;

    //Events allow clients to react to specific
    //contract changes you declare
    /* Event is an  inheritable member of a contract. An event is emmitted, it stores the arguments passed in transaction logs.
    These logs are stored on the blockchain and are accessible using address of the contract till the contract is present on the blockchain.*/
    event Sent(address from, address to, uint amount);
    

    // constructor code  only runs when contract
    //is created
    constructor() {
        minter = msg.sender;
    }
     

     //send an amount of newly created coins to an address
     //Can only be called  by the contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount; 
    }

    //Errors allow you to provide information about 
    // why an operator failed. They are returened 
    // to the caller of the funtion.
    // to the caller of the section.
    error insufficientBalance(uint requested, uint available);

    //send an amount of existing coins
    //from any caller to the address
    function send(address receiver, uint amount) public {
        //condition to enable user not to send amount of coin  not available
        if(amount > balances [msg.sender]);
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }


}