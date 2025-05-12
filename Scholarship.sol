// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Scholarship {
    address public admin; // The person deploying the contract (e.g., you or an institution)
    mapping(address => bool) public eligibleStudents; // Tracks who’s eligible
    mapping(address => uint256) public funds; // Tracks funds sent to students

    constructor() {
        admin = msg.sender; // Sets you as the admin when you deploy it
    }

    function registerStudent(address student) public {
        require(msg.sender == admin, "Only admin can register"); // Only you can call this
        eligibleStudents[student] = true; // Marks a student as eligible
    }

    function disburseFunds(address student) public payable {
        require(msg.sender == admin, "Only admin can disburse"); // Only you can send funds
        require(eligibleStudents[student], "Student not eligible"); // Checks eligibility
        funds[student] += msg.value; // Updates the student’s fund balance
        payable(student).transfer(msg.value); // Sends the test ETH to the student
    }

    function checkFunds() public view returns (uint256) {
        return funds[msg.sender]; // Lets a student see their funds
    }
}