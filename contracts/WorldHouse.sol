// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

/// @notice a house purchase game
contract WorldHouse{

    // contract owner
    address private owner;

    /// @notice the house data structure, a house has a unique 
    /// position (row, col) and a buiding type id. the used mark if 
    /// position (row, col) has been built a house
    struct HouseData{
        uint16 row;
        uint16 col;
        uint16 id;
        uint8 used;
    }
    
    // every player can only have one house, its relationship record in the map
    mapping(address => HouseData) houseRecord;

    // mapping from land position to its owner
    mapping(uint16 => mapping(uint16 => address)) landRecord;

    // mapping from land position to environment building id 
    mapping(uint16 => mapping(uint16 => uint16)) envRecord;

    // how many buildings have been built on the world, more building, higher
    // building price
    uint count;

    // buy house event
    event BuySuccess(address buyer);

    constructor() {
        owner = msg.sender;
    }

    /// @notice return the player's house
    /// @return row house row
    /// @return col house col
    /// @return houseId house id 
    /// @return used iif house has been built on this land
    function getHouse() public view returns(uint16 row, 
        uint16 col, uint16 houseId, uint8 used){
        HouseData storage data = houseRecord[msg.sender];
        return (data.row, data.col, data.id, data.used);
    }

    /// @notice return a list of owners' house ids
    /// @param owners a list of owners
    /// @return houseList a list of house ids
    function getHouses(address[] memory owners) public view returns(
        uint[] memory houseList) {
        uint len = owners.length;
        uint[] memory datas = new uint[](len);
        for(uint8 i = 0; i < len; i++){
            HouseData storage house = houseRecord[owners[i]];
            datas[i] = house.id;
        }
        return datas;
    }

    /// @notice return a list of building ids relative to the position list
    /// @param rows position rows
    /// @param cols position cols
    /// @return buildingIdList building id list
    function getEnvs(uint16[] memory rows, uint16[] memory cols) 
        public view returns(uint16[] memory buildingIdList){
        uint16[] memory envs = new uint16[](rows.length);
        for(uint8 i = 0; i < rows.length; i++){
            uint16 row = rows[i];
            uint16 col = cols[i];
            envs[i] = envRecord[row][col];
        }
        return envs;
    }

    /// @notice buy a house, every player can only buy one house, and
    /// the land is not owned by other players
    /// @param row land's row
    /// @param col land's col
    /// @param id bulding id
    function buyHouse(uint16 row, uint16 col, uint16 id) public onlyOne 
        targetNotOwned(row, col) payable{
        _addRecord(row, col, id);
        count++;
        emit BuySuccess(msg.sender);
    }

    /// @notice buy an environment building
    /// @param row land's row
    /// @param col land's col
    /// @param id bulding id
    function buyEnv(uint16 row, uint16 col, uint16 id) public 
        targetNotOwned(row, col) payable{
        envRecord[row][col] = id;
        count++;
        emit BuySuccess(msg.sender);
    }

    /// @notice return lands' owners
    /// @param rows land rows list
    /// @param cols land cols list
    /// @return owners land owners list
    function getLandOwners(uint16[] memory rows, uint16[] memory cols) 
        public view returns(address[] memory owners){
        address[] memory landOwners = new address[](rows.length);
        for(uint8 i = 0; i < rows.length; i++){
            uint16 row = rows[i];
            uint16 col = cols[i]; 
            landOwners[i] = landRecord[row][col];
        }
        return landOwners;
    }


    /// @notice move owner's house to another land
    /// @param row house row
    /// @param col house col
    function move(uint16 row, uint16 col) public targetNotOwned(row, col)  {
        HouseData storage data = houseRecord[msg.sender];
        require(data.used == 1, "You do not have a house!");

        landRecord[data.row][data.col] = address(0);
        _addRecord(row, col,data. id);
    }

    /// @notice building price, base on building amount
    function getBasePrice() public view returns(uint){
        if(count <= 1000) return 1e15;
        else if(count <= 1000000) return 1e16;
        else return 1e17;
    }

    /// @notice check if contract owner
    function isOwner() public view returns(bool){
        return msg.sender == owner;
    }


    /// @notice return contract's balance
    function getBalance() public view ownerAccess returns(uint){
        return address(this).balance;
    }

    /// @notice withdraw contract's balance
    function withdraw() public ownerAccess {
        payable(owner).transfer(getBalance());
    }

    /// @notice require contract owner
    modifier ownerAccess(){
        require(msg.sender == owner, "Access denied");
        _;
    }

    /// @notice require house has been built
    modifier onlyOne(){
        require(houseRecord[msg.sender].used != 1, "Already has one");
        _;
    }

    /// @notice require land has not been owned, and no envrionment building on
    modifier targetNotOwned(uint16 row, uint16 col){
        require(landRecord[row][col] == address(0), "The land is owned by someone!");
        require(envRecord[row][col] == 0, "The land is owned by someone!");
        _;
    }

    /// @notice mark the used land 
    function _addRecord(uint16 row, uint16 col, uint16 id) private{
        HouseData memory data = HouseData(row, col, id, 1);
        houseRecord[msg.sender] = data;
        landRecord[row][col] = msg.sender;
    }
}