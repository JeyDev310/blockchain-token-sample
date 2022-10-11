// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract AuthorizableU is OwnableUpgradeable {
    ////////////////////////////////////////////////////////////////////////
    // State variables
    ////////////////////////////////////////////////////////////////////////

    mapping(address => bool) public isAuthorized;

    ////////////////////////////////////////////////////////////////////////
    // Events & Modifiers
    ////////////////////////////////////////////////////////////////////////

    event AddedAuthorized(address _user);
    event RemovedAuthorized(address _user);

    modifier onlyAuthorized() {
        require(isAuthorized[msg.sender] || owner() == msg.sender, "caller is not authorized");
        _;
    }

    ////////////////////////////////////////////////////////////////////////
    // Initialization functions
    ////////////////////////////////////////////////////////////////////////

    function __Authorizable_init() internal virtual initializer {
        __Ownable_init();
    }

    ////////////////////////////////////////////////////////////////////////
    // External functions
    ////////////////////////////////////////////////////////////////////////
    function addAuthorized(address _toAdd) public onlyOwner {
        isAuthorized[_toAdd] = true;

        emit AddedAuthorized(_toAdd);
    }

    function removeAuthorized(address _toRemove) public onlyOwner {
        require(_toRemove != msg.sender);
        
        isAuthorized[_toRemove] = false;

        emit RemovedAuthorized(_toRemove);
    }

    ////////////////////////////////////////////////////////////////////////
    // Internal functions
    ////////////////////////////////////////////////////////////////////////
}
