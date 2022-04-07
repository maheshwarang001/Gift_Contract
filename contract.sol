pragma solidity ^0.5.7;

contract Has{

    address owner;
    uint fortune;
    bool deceased;


    constructor() payable public {
        owner = msg.sender; //msg sender represents address that is been sent
        fortune = msg.value; //value tells us how much ether is being sent
        deceased = false;

    }

    //create modifier only owner can call the contract
    modifier onlyOwner{
        require(msg.sender == owner);
        _; //continue function
    }

    //create modifier so that owner only sends funds after his demise
    modifier checkDeath{
        require(deceased == true);
        _; //continue function 
    }

    address payable [] familyWallets; //array family wallet

    mapping(address => uint) inheritance;


    //set inheritance for each address

    function seInheritance(address payable wallet, uint amount) public onlyOwner{

        familyWallets.push(wallet);
        inheritance[wallet] = amount;

    }

    //pay each family member based on their wallet address after death

    function payOut() private checkDeath{

        for(uint i = 0; i<familyWallets.length; i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
         // transferring funds from contract address to reciever address
        }

    }

    function death()public onlyOwner{
        deceased = true;
        payOut();
    
    }

}