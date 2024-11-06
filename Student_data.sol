// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {
    
    // Structure to define a Student
    struct Student {
        uint id;
        string name;
        uint age;
        string course;
    }
    
    // Array to store all students
    Student[] public students;

    // Mapping to check if a student exists by ID
    mapping(uint => bool) private studentExists;

    // Event to log when a student is added
    event StudentAdded(uint id, string name, uint age, string course);

    // Function to add a new student
    function addStudent(uint _id, string memory _name, uint _age, string memory _course) public {
        require(!studentExists[_id], "Student with this ID already exists.");
        
        students.push(Student(_id, _name, _age, _course));
        studentExists[_id] = true;
        
        emit StudentAdded(_id, _name, _age, _course);
    }
    
    // Function to retrieve a student's data by index
    function getStudent(uint index) public view returns (uint, string memory, uint, string memory) {
        require(index < students.length, "Index out of bounds.");
        Student memory student = students[index];
        return (student.id, student.name, student.age, student.course);
    }

    // Fallback function to handle Ether sent to the contract by mistake
    fallback() external payable {
        revert("Contract does not accept Ether.");
    }
    
    // Function to get the total number of students
    function getTotalStudents() public view returns (uint) {
        return students.length;
    }
}
