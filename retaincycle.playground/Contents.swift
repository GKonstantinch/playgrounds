//: Playground - noun: a place where people can play

import Foundation

class Holder {
    var ivar : Holder? = nil
    
    init() {
        print("Holder init")
    }
    
    deinit {
        print("Holder deinit")
    }
}

autoreleasepool {
    let holder1 = Holder()
    let holder2 = Holder()
    
    holder1.ivar = holder2
    holder2.ivar = holder1
    
    holder1.ivar = nil
}

print("-----------")

class WeakHolder {
    weak var ivar : WeakHolder? = nil
    
    init() {
        print("WeakHolder init")
    }
    
    deinit {
        print("WeakHolder deinit")
    }
}

autoreleasepool {
    let holder1 = WeakHolder()
    let holder2 = WeakHolder()
    
    holder1.ivar = holder2
    holder2.ivar = holder1
}
