//: Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class ViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.sync {
                print("2")
            }
            print("3")
        }
        print("1")
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                print("3")
            }
            print("2")
        }
        print("1")
        DispatchQueue.global(qos: .background).sync {
            DispatchQueue.main.async {
                print("2")
            }
            print("1")
        }
        print("1")
    }
}

PlaygroundPage.current.liveView = ViewController()
