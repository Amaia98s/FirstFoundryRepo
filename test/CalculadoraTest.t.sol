//Licence
//SPDX-License-Identifier: LGPL-3.0-only

//Solidity version
pragma solidity 0.8.24;

import "../src/Calculadora.sol";
import "forge-std/Test.sol";

contract CalculadoraTest is Test{

    Calculadora calculadora;
    uint256 public firstResultado = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public{
        calculadora = new Calculadora (firstResultado, admin);
    }

    //Unit testing

    function testFirsResultado() public view{
        uint256 firstResultado_ = calculadora.resultado();
        assert(firstResultado_ == firstResultado);
    }

    function testAddition () public{
        vm.startPrank(admin);
        uint256 num1_=5;
        uint256 num2_ =5;

        uint256 resultado_ = calculadora.addition(num1_,num2_);

        assert(resultado_ == num1_ + num2_);

        vm.stopPrank();
    }

    function testSubstraction () public{
        vm.startPrank(admin);
        uint256 num1_=5;
        uint256 num2_ =5;

        uint256 resultado_ = calculadora.substraction(num1_,num2_);

        assert(resultado_ == num1_ - num2_);

        vm.stopPrank();
    }

    function testMultiplier () public{
        vm.startPrank(admin);
        uint256 num1_=5;
        uint256 num2_ =5;

        uint256 resultado_ = calculadora.multiplier(num1_, num2_);

        assert(resultado_ == num1_ * num2_);

        vm.stopPrank();
    }

    function testCanNotMultiplyLargeNumbers() public{
        vm.startPrank(admin);
        uint256 num1_=115792089237316195423570985008687907853269984665640564039457584007913129639934;
        uint256 num2_ =5;

        vm.expectRevert();

        calculadora.multiplier(num1_, num2_);

        vm.stopPrank();
    }

    function testIfNotAdminCallsDivisionReverts() public{
        vm.startPrank(randomUser);

        uint256 num1_= 5;
        uint256 num2_=5;
        vm.expectRevert();
        calculadora.division(num1_,num2_);

        vm.stopPrank();
    }

    function testAdminCanCallDivision() public{
        vm.startPrank(admin);

        uint256 num1_= 5;
        uint256 num2_=5;
        
        calculadora.division(num1_,num2_);

        vm.stopPrank();
    }

    function testDefaultExecutesCorrectly()public{
        vm.startPrank(admin);

        uint256 num1_=5;
        uint256 num2_=2;
        uint256 result_= calculadora.division(num1_, num2_);
        assert(result_ == num1_/num2_);

        vm.stopPrank();
    }

    function testCanNotDivideByZero() public{
        vm.startPrank(admin);

        uint256 num1_=5;
        uint256 num2_=0;
        vm.expectRevert();
        calculadora.division(num1_, num2_);
       

        vm.stopPrank();
    }


    //Fuzzing testing

    function testFuzzingDivision(uint256 num1_, uint256 num2_) public{
        vm.assume(num2_ != 0);
        vm.startPrank(admin);
        calculadora.division(num1_, num2_);
        vm.stopPrank();

    }
        
}