//: Playground - noun: a place where people can play

import Foundation

class A {
    init() {
        
    }
    
    init(designatedA: String) {
        print(designatedA)
    }
    
    convenience init(convenienceA: String) {
        self.init(designatedA: convenienceA)
    }
}

class B: A {
    // to get all super inits include convenience we must directly override ALL DESIGNATED inits
    override init() {
        super.init()
    }
    
    override init(designatedA: String) {
        super.init(designatedA: designatedA)
    }
}

class C: B {
    // or let it will be done implicitly
}

let a = A(convenienceA: "a")
let b = B(convenienceA: "b")
let c = C(convenienceA: "c")

