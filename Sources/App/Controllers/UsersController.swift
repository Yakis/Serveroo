//
//  UsersController.swift
//  App
//
//  Created by Mugurel Moscaliuc on 28/05/2018.
//

import FluentPostgreSQL
import Vapor
import FluentSQL


final class UsersController: RouteCollection {
    
    
    func boot(router: Router) throws {
        let users = router.grouped("users")
        
        users.post(User.self, use: create)
        users.get(use: getAll)
        users.get(User.parameter, use: getOne)
        users.get(use: searchByName)
    }
    
    
    func getAll(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    
    func getOne(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    
    func create(_ req: Request, _ user: User) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    
    func searchByName(_ req: Request) throws -> Future<User> {
        let username: String = try req.query.get(at: "username")
        print("You're looking for a user named=== \(username)")
        return req.withNewConnection(to: .psql) { db -> Future<User> in
            return try db.query(User.self).filter(\User.username ~~ username).first().map(to: User.self) { user in
                guard let user = user else {
                    throw Abort(.notFound, reason: "Could not find user.")
                }
                
                return user
            }
        }
    }
    
    
}



