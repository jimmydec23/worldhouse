const WorldHouse = artifacts.require("WorldHouse");

contract("WorldHouse", () => {
    it("Should handle house data right", async() => {
        const ins = await WorldHouse.deployed();
        const {row, col, houseId, used}= await ins.getHouse();
        assert.equal(row, 0, "should be an empty house");
        assert.equal(col, 0, "should be an empty house");
        assert.equal(houseId, 0, "should be an empty house");
        assert.equal(used, 0, "should be an empty house");
    })
})