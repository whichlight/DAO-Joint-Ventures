var MockERC20 = artifacts.require("/Users/shakezula/dev/jointdao/contracts/ERC20Mock.sol");
var JVDAOFactory = artifacts.require("/Users/shakezula/dev/jointdao/contracts/JVDaoIF.sol");

contract('JVDaoIF', (accounts) => {
    var creatorAddress = accounts[0];
    var firstOwnerAddress = accounts[1];
    var secondOwnerAddress = accounts[2];
    var externalAddress = accounts[3];
    var unprivilegedAddress = accounts[4]
    /* create named accounts for contract roles */

    before(async () => {
        /* before tests */
    })
    
    beforeEach(async () => {
        token1 = MockERC20("DAO0", "DAO0", accounts[1], 100)
        token2 = MockERC20("DAO1", "DAO1", accounts[2], 100)
    })

    it('should return a JVDAO Factory', () => {
        return JVDAOFactory.deployed()
            .then(instance => {
                console.log(instance)
            })
    })

    // it('should revert if ...', () => {
    //     return JVDAOFactory.deployed()
    //         .then(instance => {
    //             return instance.publicOrExternalContractMethod(argument1, argument2, {from:externalAddress});
    //         })
    //         .then(result => {
    //             assert.fail();
    //         })
    //         .catch(error => {
    //             assert.notEqual(error.message, "assert.fail()", "Reason ...");
    //         });
    //     });

    // context('testgroup - security tests - description...', () => {
    //     //deploy a new contract
    //     before(async () => {
    //         /* before tests */
    //         const newJVDaoIF =  await JVDaoIF.new()
    //     })
        

    //     beforeEach(async () => {
    //         /* before each tests */
    //     })

        

    //     it('fails on initialize ...', async () => {
    //         return assertRevert(async () => {
    //             await newJVDaoIF.initialize()
    //         })
    //     })

    //     it('checks if method returns true', async () => {
    //         assert.isTrue(await newJVDaoIF.thisMethodShouldReturnTrue())
    //     })
    // })
});
