//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

class Node {
    var value: Int = 0 {
        didSet {
            for child in children {
                child.value = value
                print("Value changed")
            }
        }
    }
    
    var children = [Node]()
}

let a = Node()
let b = Node()
let c = Node()
let d = Node()

a.children.append(b)
b.children.append(c)
c.children.append(d)
d.children.append(a)

a.value = 2

print(a.value)
print(b.value)
print(c.value)
print(d.value)
