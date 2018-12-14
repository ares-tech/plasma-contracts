pragma solidity ^0.4.0;

import "./PriorityQueueLib.sol";

/**
 * @title PriorityQueue
 * @dev Min-heap priority queue implementation.
 */
contract PriorityQueue {
    using SafeMath for uint256;

    /*
     *  Storage
     */

    address owner;
    uint256[] heapList;
    uint256 public currentSize;


    /*
     *  Modifiers
     */

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    /*
     * Constructor
     */

    constructor()
        public
    {
        owner = msg.sender;
        heapList = [0];
        currentSize = 0;
    }


    /*
     * Internal functions
     */

    /**
     * @dev Inserts an element into the priority queue.
     * @param _element Integer to insert.
     */
    function insert(uint256 _element)
        public
        onlyOwner
    {
        (heapList, currentSize) = PriorityQueueLib.insert(heapList, currentSize, _element);
    }

    /**
     * @dev Returns the top element of the heap.
     * @return The smallest element in the priority queue.
     */
    function getMin()
        public
        view
        returns (uint256)
    {
        return PriorityQueueLib.getMin(heapList, currentSize);
    }

    /**
     * @dev Deletes the top element of the heap and shifts everything up.
     * @return The smallest element in the priorty queue.
     */
    function delMin()
        public
        onlyOwner
        returns (uint256)
    {
        uint256 retVal;
        (heapList, currentSize, retVal) = PriorityQueueLib.delMin(heapList, currentSize);
        return retVal;
    }

}
