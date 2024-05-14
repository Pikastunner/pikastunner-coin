// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
import "hardhat/console.sol";

contract HelloWorld {
  /**
   * @dev Prints Hello World string
   */
  function print() public pure returns (string memory) {
    return "Hello World!";
  }
}

contract TokenExchange {
  /**
   * @dev Token exchange 
   */
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupplied;
  mapping(address => uint256) public balanceOf;
  mapping(address => uint256) public loaningOf;
  mapping(address => mapping(address => uint256)) public allowance;

  uint256 public upfrontPercentage; // Fee percentage (e.g., 1% fee = 100)
  uint256 public interestRates; // Fee percentage (e.g., 1% fee = 100)
  uint256 public startCapital;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
  event upfrontFeeCollected(address indexed from, uint256 amount);
  event InterestCharged(address indexed borrower, uint256 amount);

  constructor(
    string memory _name,
    string memory _symbol,
    uint8 _decimals,
    uint256 _initialSupply,
    uint256 _feePercentage,
    uint256 _interestRates,
    uint256 _startCapital) {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    totalSupplied = _initialSupply * 10 ** uint256(_decimals);
    balanceOf[msg.sender] = totalSupplied;
    upfrontPercentage = _feePercentage;
    interestRates = _interestRates;
    startCapital = _startCapital;
  }

  function upfrontPayment(address _to, uint256 _value) private {
    uint256 feeAmount = (_value * upfrontPercentage) / 10000;
    balanceOf[msg.sender] += feeAmount;
    balanceOf[_to]-= feeAmount;
  }

  function startingCapital(address _to, uint256 _value) public returns (bool success) {
    require(_to != address(0), "Invalid recipient address");
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] = _value;
    return true;
  }

  function transfer(address _to, uint256 _value) public returns (bool success) {
    uint256 feeAmount = (_value * upfrontPercentage) / 10000;
    require(_to != address(0), "Invalid recipient address");
    require(balanceOf[msg.sender] >= _value, "Insufficient balance");
    require(balanceOf[_to] >= feeAmount, "Insufficient for upfront payment");

    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    loaningOf[_to] += _value;
    emit Transfer(msg.sender, _to, _value);

    upfrontPayment(_to, _value);
    emit upfrontFeeCollected(msg.sender, feeAmount);
    return true;
  }

  function approve(address _spender, uint256 _value) public returns (bool success) {
    allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(_to != address(0), "Invalid recipient address");
    require(balanceOf[msg.sender] >= _value, "Insufficient balance");
    require(allowance[msg.sender][_from] >= _value, "Allowance Exceeded");

    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    allowance[msg.sender][_from] -= _value;
    emit Transfer(_from, _to, _value);
    return true;
  }

  function chargeInterest(address _borrower) public returns (bool success) {
    require(_borrower != address(0), "Invalid recipient address");
    uint256 interest = (loaningOf[_borrower] * interestRates) / 10000;
    console.log(loaningOf[_borrower] / 10**18);
    console.log(balanceOf[_borrower] - interest);
    balanceOf[_borrower] -= interest;
    balanceOf[msg.sender] += interest;
    emit InterestCharged(_borrower, interest);
    return true;
  }

  function totalSupply() public view returns (uint256) {
    return totalSupplied;
  }

  function obtainBalanceOf(address _viewer) public view returns (uint256) {
    return balanceOf[_viewer];
  }

  function obtainAllowanceOf(address _viewer) public view returns (uint256) {
    return allowance[msg.sender][_viewer];
  }

  function print() public pure returns (string memory) {
    return "Hello World!";
  }
}
