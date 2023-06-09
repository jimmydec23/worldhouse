const WorldHouse = artifacts.require("WorldHouse");

contract("WorldHouse", (accounts) => {
    it("Should handle house data right", async() => {
        const ins = await WorldHouse.deployed();
        var {row, col, houseId, used}= await ins.getHouse();
        assert.equal(row, 0, "should be an empty house");
        assert.equal(col, 0, "should be an empty house");
        assert.equal(houseId, 0, "should be an empty house");
        assert.equal(used, 0, "should be an empty house");
        await ins.buyHouse(0,0,1)
        var {row, col, houseId, used}= await ins.getHouse();
        assert.equal(used, 1, "should be an used house");
        var [owner] = await ins.getLandOwners([0], [0]);
        assert.equal(owner, accounts[0], "should match house owner")
        await ins.move(100, 100)
        var {row, col, houseId, used}= await ins.getHouse();
        assert.equal(row, 100, "should match house position");
        assert.equal(col, 100, "should match house positon");
    })
})