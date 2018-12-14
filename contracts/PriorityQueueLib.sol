pragma solidity ^0.4.0;

import "./SafeMath.sol";


/**
 * @title PriorityQueue
 * @dev Min-heap priority queue implementation.
 */
library PriorityQueueLib {
    using SafeMath for uint256;
/*
    (owner, heapList, currentSize);


        (address, uint256[], uint256)
        */

    function insert(uint256[] storage heapList, uint256 currentSize, uint256 _element)
        returns (uint256[], uint256)
    {
        heapList.push(_element);
        currentSize = currentSize.add(1);
        (heapList, currentSize) = _percUp(heapList, currentSize, currentSize);

        return (heapList, currentSize);
    }

    function getMin(uint256[] heapList, uint256 currentSize)
        view
        returns (uint256)
    {

        return heapList[1];
    }

    function delMin(uint256[] storage heapList, uint256 currentSize)
        returns (uint256[], uint256, uint256)
    {
        uint256 retVal = heapList[1];
        heapList[1] = heapList[currentSize];
        delete heapList[currentSize];
        currentSize = currentSize.sub(1);
        (heapList, currentSize) = _percDown(heapList, currentSize, 1);
        heapList.length = heapList.length.sub(1);

        return (heapList, currentSize, retVal);
    }


    /*
     * Private functions
     */

    /**
     * @dev Determines the minimum child of a given node in the tree.
     * @param _index Index of the node in the tree.
     * @return The smallest child node.
     */
    function _minChild(uint256[] heapList, uint256 currentSize, uint256 _index)
        private
        returns (uint256)
    {
        if (_index.mul(2).add(1) > currentSize) {
            return _index.mul(2);
        } else {
            if (heapList[_index.mul(2)] < heapList[_index.mul(2).add(1)]) {
                return _index.mul(2);
            } else {
                return _index.mul(2).add(1);
            }
        }
    }

    /**
     * @dev Bubbles the element at some index up.
     */
    function _percUp(uint256[] storage heapList, uint256 currentSize, uint256 _index)
        private
        returns (uint256[] storage, uint256)
    {
        uint256 index = _index;
        uint256 j = index;
        uint256 newVal = heapList[index];
        while (newVal < heapList[index.div(2)]) {
            heapList[index] = heapList[index.div(2)];
            index = index.div(2);
        }
        if (index != j) heapList[index] = newVal;

        return (heapList, currentSize);
    }

    /**
     * @dev Bubbles the element at some index down.
     */
    function _percDown(uint256[] storage heapList, uint256 currentSize, uint256 _index)
        private
        returns (uint256[] storage, uint256)
    {
        uint256 index = _index;
        uint256 j = index;
        uint256 newVal = heapList[index];
        uint256 mc = _minChild(heapList, currentSize, index);
        while (mc <= currentSize && newVal > heapList[mc]) {
            heapList[index] = heapList[mc];
            index = mc;
            mc = _minChild(heapList, currentSize, index);
        }
        if (index != j) heapList[index] = newVal;

        return (heapList, currentSize);
    }
}
