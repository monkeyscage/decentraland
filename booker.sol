contract Buyer{address public owner;function Buyer(address o){owner=o;}finalize(address a){}}


contract booker{
address public owner;
mapping(uint => mapping(uint => bool))public taken;
mapping(uint => mapping(uint => address))public owners;
mapping(uint => mapping(uint => uint))public cost;
mapping(uint => mapping(uint => uint))public payed;
uint public bookingCost;
address public buyer;
Buyer BuyContract;


function booker(uint b){
bookingCost=b;
owner=msg.sender;
}

function setBuyerContract(address b){if(msg.sender!=owner)revert();buyer=b; BuyContract= new Buyer(owner);}

function book(uint x,uint y) payable returns(bool){
if(!msg.value>0)revert();
if((!x>0)&&(!x<22))revert();
if((!y>0)&&(!y<48))revert();
uint tempCost;
if(cost[x][y]>0){tempCost=cost[x][y]}else{tempCost=1200;}
if(!taken[x][y])if(msg.value>=tempCost){
taken[x][y]=true;
address tempOwner;
tempOwner=owners[x][y];
owners[x][y]=msg.sender;
if(!tempOwner.send(msg.value))revert();
}else{revert();}
return true;
}

function rejectBooking(uint x,uint y){
if((!x>0)&&(!x<22))revert();
if((!y>0)&&(!y<48))revert();
if(owners[x][y]!=msg.sender)revert();
owners[x][y]=owner;
taken[x][y]=false;
if(!owners[x][y].send(1200))revert();
}



function setCost(uint x,uint y,uint c){
if(owners[x][y]!=msg.sender)revert();
cost[x][y]=c;
}

finalizeBooking(uint x,uint y){
if(owners[x][y]!=msg.sender)revert();
if(!buyer.finalize(x,y))revert();
}

}
