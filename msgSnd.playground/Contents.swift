//: Playground - noun: a place where people can play

import Foundation

class High {
    func saySome() {
        print("so high")
    }
}

class Mid: High {
    override func saySome() {
        print("in the middle")
    }
    
    func one() {
        super.saySome()
    }
    
    func two() {
        saySome()
    }
}

class Low: Mid {
    override func saySome() {
        print("down")
    }
}

Mid().one()
Low().one()

Mid().two()
Low().two()
