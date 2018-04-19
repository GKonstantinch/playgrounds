//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

typealias BlockType = () -> Void

class Test {
    private var _completion: BlockType?
    private var _timer: Timer?
    
    init() {
        print("Test init")
    }
    
    func runWithCompleteion(completion: BlockType?) -> Void {
        _completion = completion
        
        _timer = Timer.scheduledTimer(timeInterval: 0.9,
                                      target: self,
                                      selector: #selector(self.peep),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    @objc func peep() -> Void {
        print("peep")
        if let completion = _completion {
            completion()
            _timer?.invalidate()
        }
    }
    
    deinit {
        print("Test deinit")
    }
}

class Tester {
    let _mainRunloop = RunLoop.current
    let _timer: Timer
    
    init() {
        print("Tester init")
        
        _timer = Timer.init(timeInterval: 0.3,
                            repeats: true,
                            block: { timer in print("fire") })
        
        _mainRunloop.add(_timer,
                         forMode: RunLoopMode.defaultRunLoopMode)
        
        let test = Test()
        test.runWithCompleteion(completion: { self.complete() })
    }
    
    func complete() {
        _timer.invalidate()
    }
    
    deinit {
        print("Tester deinit")
    }
}

weak var tester = Tester()
tester = nil 
