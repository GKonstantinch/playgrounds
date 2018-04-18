//: Playground - noun: a place where people can play

import UIKit

extension Array where Element: Comparable {
    func binarySearchIndexOf(element: Element) -> Int {
        guard count > 0 else {
            return 0
        }
        return binarySearch(element, 0, count - 1)
    }
    
    func binarySearch(_ element: Element, _ indexFirst: Int, _ indexLast: Int) -> Int {
        let indexMiddle = indexFirst + (indexLast-indexFirst) / 2
        
        let middleElement = self[indexMiddle]
        
        if middleElement == element {
            return indexMiddle
        }
        
        if indexFirst == indexLast {
            return element > middleElement ? indexMiddle + 1 : indexMiddle
        }
        
        if middleElement > element {
            return binarySearch(element, indexFirst, indexMiddle)
        } else {
            return binarySearch(element, indexMiddle + 1, indexLast)
        }
    }
}

let arr = [1,5,8,9,12,18,25,1005]

arr.binarySearchIndexOf(element: 25)
