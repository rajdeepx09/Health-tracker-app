// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthTracker {
    // Struct to store health data
    struct HealthRecord {
        uint256 timestamp;
        uint256 weight;
        uint256 bloodPressureSystolic;
        uint256 bloodPressureDiastolic;
        uint256 heartRate;
        string notes;
    }

    // Mapping to store health records for each user
    mapping(address => HealthRecord[]) private userHealthRecords;

    // Event to log when a new health record is added
    event HealthRecordAdded(
        address indexed user, 
        uint256 timestamp, 
        uint256 weight, 
        uint256 bloodPressureSystolic, 
        uint256 bloodPressureDiastolic, 
        uint256 heartRate
    );

    // Function to add a new health record
    function addHealthRecord(
        uint256 _weight,
        uint256 _bloodPressureSystolic,
        uint256 _bloodPressureDiastolic,
        uint256 _heartRate,
        string memory _notes
    ) public {
        HealthRecord memory newRecord = HealthRecord({
            timestamp: block.timestamp,
            weight: _weight,
            bloodPressureSystolic: _bloodPressureSystolic,
            bloodPressureDiastolic: _bloodPressureDiastolic,
            heartRate: _heartRate,
            notes: _notes
        });

        userHealthRecords[msg.sender].push(newRecord);

        emit HealthRecordAdded(
            msg.sender, 
            newRecord.timestamp, 
            _weight, 
            _bloodPressureSystolic, 
            _bloodPressureDiastolic, 
            _heartRate
        );
    }

    // Function to retrieve all health records for the caller
    function getMyHealthRecords() public view returns (HealthRecord[] memory) {
        return userHealthRecords[msg.sender];
    }

    // Function to get the latest health record
    function getLatestHealthRecord() public view returns (HealthRecord memory) {
        HealthRecord[] storage records = userHealthRecords[msg.sender];
        require(records.length > 0, "No health records found");
        return records[records.length - 1];
    }

    // Function to get the number of health records
    function getHealthRecordCount() public view returns (uint256) {
        return userHealthRecords[msg.sender].length;
    }
}