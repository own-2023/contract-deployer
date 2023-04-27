const { assert } = require('chai')

const Color = artifacts.require('./Color.sol')


contract('Color', (accounts) => {
    let contract

    before(async () => {
        contract = await Color.deployed()
    })

    describe('deployment', async () => {
        it('Deploys succesfully ', async () => {
            const address = contract.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })

        it('has a name', async () => {
            const name = await contract.name();
            assert.equal(name, 'Color')
        })

        it('has a symbol', async () => {
            const symbol = await contract.symbol();
            assert.equal(symbol, 'COLOR')
        });
    })

    describe('minting', async () => {
        it('create a new token', async () => {
            const result = await contract.mint('#EC058E')
            const totalSupply = await contract.totalSupply()
            //SUCCESS
            assert.equal(totalSupply, 1)
            const event = result.logs[0].args
            assert.equal(event.tokenId.toNumber(), 1, 'id is correct')
            assert.equal(event.from, '0x0000000000000000000000000000000000000000')
            assert.equal(event.to, accounts[0], 'to is correct')
        })
            
    })

    describe('indexing', async () => {
        it('lists colors', async () => {
            await contract.mint('#5386E4')
            await contract.mint('#FFFFFF')
            await contract.mint('#000000')
            const totalSupply = await contract.totalSupply()
        })
    })

})