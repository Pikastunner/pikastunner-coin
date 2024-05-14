// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
//import "../.deps/remix-tests/remix_accounts.sol";
import "contracts/HelloWorld.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    TokenExchange token;
    function beforeEach() public {
        token = new TokenExchange("ERC-20 Trade", "ERC-20", 18, 1000000, 10, 10, 100);
    }

    function checkInitialValues() public {
        Assert.equal(token.name(), "ERC-20 Trade", "Name should be ERC-20 Trade");
        Assert.equal(token.symbol(), "ERC-20", "Symbol should be ERC-20");
        Assert.equal(token.decimals(), uint8(18), "Decimals should be 18");
        Assert.equal(token.totalSupplied(), 1000000 * 10 ** 18, "Total supply should be 1000000");
        Assert.equal(token.balanceOf(address(this)), 1000000 * 10 ** 18, "Contract creator should have total supply");
    }

    function checkTransfer() public {
        address recipient = TestsAccounts.getAccount(1);
        uint256 amount = 100 * 10 ** 18;
        
        Assert.equal(token.startingCapital(recipient, 100 * 10 ** 18), true, "Given test account starting capital");
        Assert.equal(token.transfer(recipient, amount), true, "Working function");
        Assert.equal(token.balanceOf(address(this)), 1000000 * 10 ** 18 - 2*amount + amount * 10 / 10000, "Sender balance should decrease");
        Assert.equal(token.balanceOf(recipient), 2*amount - amount * 10 / 10000, "Recipient's balance should increase");
    }

    function checkApproval() public {
        address spender = TestsAccounts.getAccount(1);
        uint256 allowanceAmount = 100 * 10 ** 18;
        
        token.approve(spender, allowanceAmount);
        Assert.equal(token.allowance(address(this), spender), 100 * 10 ** 18, "Allowance should be set");
    }

    function checkTransferFrom() public {
        address spender = TestsAccounts.getAccount(1);
        address recipient = TestsAccounts.getAccount(2);
        uint256 amount = 100 * 10 ** 18;

        token.approve(spender, amount);
        token.transferFrom(spender, recipient, amount);
        
        Assert.equal(token.balanceOf(address(this)), 1000000 * 10 ** 18 - amount, "Sender balance should decrease");
        Assert.equal(token.allowance(address(this), spender), 0, "Sender balance should decrease");
        Assert.equal(token.balanceOf(recipient), amount, "Recipient's balance should increase");
    }

    function checkchargeInterest() public {
        address recipient = TestsAccounts.getAccount(1);
        uint256 amount = 100 * 10 ** 18;

        Assert.equal(token.startingCapital(recipient, amount), true, "Given test account starting capital");
        Assert.equal(token.transfer(recipient, amount), true, "Started a loan");
        Assert.equal(token.chargeInterest(recipient), true, "Charged for interest");
        Assert.equal(token.balanceOf(address(this)), 1000000 * 10 ** 18 - 2*amount + 2*amount * 10 / 10000, "Sender balance should decrease");
        Assert.equal(token.balanceOf(recipient), 2*amount - 2*amount * 10 / 10000, "Recipient's balance should increase");
    }

    function checkTotalSupply() public {
        Assert.equal(token.totalSupply(), 1000000 * 10 ** 18, "Total Supply is correct");
    }
    
    function checkobtainBalanceOf() public {
        Assert.equal(token.obtainBalanceOf(address(this)), 1000000 * 10 ** 18, "Balance of is correct");
    }
    
    function checkobtainAllowanceOf() public  {
        Assert.equal(token.obtainAllowanceOf(address(this)), 0, "No allowance");
    }

}
    