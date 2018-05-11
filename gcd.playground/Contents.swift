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
                print("6")
            }
            print("9")
        }
        print("1")
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                print("8")
            }
            print("5")
        }
        print("2")
        DispatchQueue.global(qos: .background).sync {
            DispatchQueue.main.async {
                print("7")
            }
            print("3")
        }
        print("4")
    }
}

PlaygroundPage.current.liveView = ViewController()
