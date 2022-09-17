const JVDaoIF = artifacts.require("JVDaoIF");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("JVDaoIF", function (/* accounts */) {
  it("should assert true", async function () {
    await JVDaoIF.deployed();
    return assert.isTrue(true);
  });
});
