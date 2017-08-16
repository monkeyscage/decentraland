contract buyer{finalize(address a){}}


contract booker{
mapping(uint => mapping(uint => bool))public taken;
mapping(uint => mapping(uint => address))public owners;
mapping(uint => mapping(uint => uint))public cost;
uint public bookingCost;
address public buyer;


function booker(uint b){
bookingCost=b;
owner=msg.sender;
}

function setBuyerContract(address b){if(msg.sender!=owner)revert();buyer=b;}

function book(uint x,uint y) payable returns(bool){
if(!taken[x][y]){
taken[x][y]=true;
owners[x][y]=msg.sender;
}else{revert();}
return true;
}

function book(uint x,uint y){
uint tempCost;
if(cost[x][y]>0){tempCost=cost[x][y]}else{tempCost=1200;}
if(!taken[x][y])if(msg.value>=tempCost){
taken[x][y]=true;
owners[x][y]=msg.sender;
}
}

function setCost(uint x,uint y,uint c){
if(owners[x][y]!=msg.sender)revert();
cost[x][y]=c;
}

finalizeBooking(){

}

}
