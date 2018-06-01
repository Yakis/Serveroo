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
        
        // /api/v1/users/create
        users.post("create", use: create)
        
        // /api/v1/users/all
        users.get("all", use: getAll)
        
        // /api/v1/users/:id
        users.get(User.parameter, use: getOne)
        users.delete(User.parameter, use: delete)
        users.patch(User.parameter, use: update)
        
        // /api/v1/users?username=:username
        users.get(use: searchByName)
        
        // /api/v1/users?uid=:firebaseUid
        users.get(use: searchByUid)
        
    }
    
    
    func getAll(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    
    func getOne(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req)
        }
    }
    
    
    func searchByName(_ req: Request) throws -> Future<User> {
        let username: String = try req.query.get(at: "username")
        return req.withNewConnection(to: .psql) { db -> Future<User> in
            return try db.query(User.self).filter(\User.username ~~ username).first().map(to: User.self) { user in
                guard let user = user else {
                    throw Abort(.notFound, reason: "Could not find user.")
                }
                return user
            }
        }
    }
    
    
    func searchByUid(_ req: Request) throws -> Future<User> {
        let uid: String = try req.query.get(at: "uid")
        return req.withNewConnection(to: .psql) { db -> Future<User> in
            return try db.query(User.self).filter(\.firebaseUid == uid).first().map(to: User.self) { user in
                guard let user = user else {
                    throw Abort(.notFound, reason: "Could not find user.")
                }
                return user
            }
        }
    }
    
    
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap { user in
            return try req.content.decode(User.self).flatMap { newUser in
                user.username = newUser.username ?? user.username
                user.email = newUser.email ?? user.email
                user.firstName = newUser.firstName ?? user.firstName
                user.lastName = newUser.lastName ?? user.lastName
                user.contactNumber = newUser.contactNumber ?? user.contactNumber
                user.postcode = newUser.postcode ?? user.postcode
                user.avatar = newUser.avatar ?? user.avatar
                user.deviceToken = newUser.deviceToken ?? user.deviceToken
                user.firebaseUid = newUser.firebaseUid ?? user.firebaseUid
                user.userType = newUser.userType ?? user.userType
                return user.save(on: req)
            }
        }
    }
    
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return User.query(on: req).all().flatMap(to: HTTPStatus.self) { users in
            return users[0].delete(on: req).transform(to: HTTPStatus.noContent)
        }
    }
    
    
    
}



