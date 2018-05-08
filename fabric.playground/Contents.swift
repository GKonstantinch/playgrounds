//: Playground - noun: a place where people can play

import UIKit

protocol WorkProtocol {
    func doSomething() -> Void
}

struct Contract {
    var job: Job
    var salary: Double
    
    enum Job {
        case iOS
        case Android
    }
}

struct iOSDeveloper: WorkProtocol {
    var salary: Double
    
    init(contact: Contract) {
        self.salary = contact.salary
    }
    
    func doSomething() {
        print("I'm making gerat apps for a \(self.salary)")
    }
}

struct AndroidDeveloper: WorkProtocol {
    var salary: Double
    
    init(contact: Contract) {
        self.salary = contact.salary
    }
    
    func doSomething() {
        print("I need more money then \(self.salary) - starting to learn swift")
    }
}

struct EmployeesFactory {
    static func getEmployee(contract: Contract) -> WorkProtocol {
        switch contract.job {
        case .Android:
            return AndroidDeveloper(contact: contract)
        case .iOS:
            return iOSDeveloper(contact: contract)
        }
    }
}

let iOSContract = Contract(job: .iOS, salary: 100.1)
let AndroidContract = Contract(job: .Android, salary: 99.9)

let employeeIOS = EmployeesFactory.getEmployee(contract: iOSContract)
let employeeAndroid = EmployeesFactory.getEmployee(contract: AndroidContract)

employeeIOS.doSomething()
employeeAndroid.doSomething()
