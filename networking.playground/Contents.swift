//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

enum Errors: Error {
    case badUserURL
    case badPostURL
}

struct Location: Codable {
   let lat: String
   let lng: String
}

struct Address: Codable {
   let city: String
   let street: String
   let suite: String
   let zipcode: String
   let geo: Location
}
 
struct Company: Codable {
   let bs: String
   let catchPhrase: String
   let name: String
}
 
struct User: Codable {
    let name: String
    let email: String
    let id: Int
    let website: String
    let phone: String
    let username: String
    let address: Address
    let company: Company
}

struct Post: Codable {
    let title: String
    let userId: Int
    let id: Int
    let body: String
}

struct NetworkLayer {
    // api points
    private let _baseURL = "https://jsonplaceholder.typicode.com"
    private let _getUsersURL = "/users"
    private let _getPostsURL = "/posts?userId="
    // network layer session
    private let _session = URLSession(configuration: .ephemeral)
    // facade for chained tasks
    func getUsers() throws {
        var _users = [User]()
        // semaphore to separate get users tasks from other
        let semaphore = DispatchSemaphore(value: 0)
        guard let usersURL = URL(string: _baseURL + _getUsersURL) else {
            throw Errors.badUserURL
        }
        let _taskUser = _session.dataTask(with: usersURL) { (data, responce, error) in
            if let realError = error {
                print(realError.localizedDescription)
                return
            }
            guard let realData = data else {
                print("Data corrupted")
                return
            }
            do {
                _users = try JSONDecoder().decode([User].self,
                                                  from: realData)
            } catch {
                print(error.localizedDescription)
            }
            semaphore.signal()
        }
        _taskUser.resume()
        semaphore.wait(timeout: .distantFuture)
        let _userIDs = _users.map({ $0.id })
        // for each user start get details task in group
        let group = DispatchGroup()
        try _userIDs.forEach({ userID in
            guard let _url = URL(string: _baseURL + _getPostsURL + String(userID)) else {
                throw Errors.badPostURL
            }
            group.enter()
            let _taskPost = _session.dataTask(with: _url) { (data, responce, error) in
                if let realError = error {
                    print(realError.localizedDescription)
                    return
                }
                guard let realData = data else {
                    print("Data corrupted")
                    group.leave()
                    return
                }
                do {
                    let _posts = try JSONDecoder().decode([Post].self,
                                                          from: realData)
                    print("user id - \(userID), user post ids - \(_posts.map({$0.id}))")
                } catch {
                    print(error.localizedDescription)
                }
                group.leave()
            }
            _taskPost.resume()
        })
        group.wait(timeout: .distantFuture)
    }
}

let service = NetworkLayer()
do {
    try service.getUsers()
} catch {
    print(error)
}

PlaygroundPage.current.finishExecution()
