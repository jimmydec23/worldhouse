const WorldHouse = artifacts.require("WorldHouse");

contract("WorldHouse", () => {
    it("Should handle right", async() => {
        const ins = await WorldHouse.deployed();
        const {row, col, id, used}= await ins.getHouse();
        assert.equal(used, 0, "house should not be used");
    })
})