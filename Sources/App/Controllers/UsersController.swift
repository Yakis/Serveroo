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
        
        // /users/create
        users.post("create", use: create)
        
        // /users/all
        users.get("all", use: getAll)
        
        // /users/:id
        users.get(User.parameter, use: getOne)
        users.delete(User.parameter, use: delete)
        users.patch(User.parameter, use: update)
        
        // /users/search?username=:username
        users.get("search", use: searchByName)
        
        // /users?uid=:firebaseUid
        users.get(use: searchByUid)
        
        // /users/settings/create
        users.post("settings", "create", use: saveSettings)
        
        // /users/settings?userId=:id
        users.get("settings", use: getSettings)
        
        // /users/settings?userId=:id
        users.patch("settings", use: updateSettings)
        
        // /users/favoriteTracks?userId=:id
        users.get("favoriteTracks", use: getFavoriteTracks)
        
        // /users/favorites?userId=1&trackId=1
        users.delete("favorites", use: removeFavorite)
        
    }
    
    
    func getAll(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    
    func getOne(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap { user in
            user.username = user.username?.lowercased()
            return user.save(on: req)
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
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
            }.transform(to: .ok)
    }
    
    
    func searchByName(_ req: Request) throws -> Future<[User]> {
        guard let searchedUsername: String = try req.query.get(at: "username") else {
            throw Abort(.badRequest)
        }
        return User.query(on: req).filter(\User.username ~~ searchedUsername).all()
    }
    
    
    func searchByUid(_ req: Request) throws -> Future<User> {
        guard let uid: String = try req.query.get(at: "uid") else {
            throw Abort(.badRequest)
        }
        return User.query(on: req).filter(\.firebaseUid == uid).first().unwrap(or: Abort(.notFound))
    }
    
    
    func saveSettings(_ req: Request) throws -> Future<Setting> {
        return try req.content.decode(Setting.self).flatMap { setting in
            return setting.save(on: req)
        }
    }

    
    func getSettings(_ req: Request) throws -> Future<[Setting]> {
        guard let userId: Int = try req.query.get(at: "userId") else { throw Abort(.notFound) }
        return User.find(userId, on: req).flatMap(to: [Setting].self)  { user in
            guard let unwrappedUser = user else { throw Abort.init(HTTPStatus.notFound) }
            return try unwrappedUser.settings.query(on: req).all()
        }
    }
    
    
    func updateSettings(_ req: Request) throws -> Future<Setting> {
        guard let userId: Int = try req.query.get(at: "userId") else { throw Abort(.badRequest) }
        return Setting.query(on: req).filter(\.userId == userId).first().flatMap { settings in
            guard let settings = settings else { throw Abort(.notFound) }
            return try req.content.decode(Setting.self).flatMap { newSettings in
                settings.locationEnabled = newSettings.locationEnabled ?? settings.locationEnabled
                settings.tagNotify = newSettings.tagNotify ?? settings.tagNotify
                settings.trackUpdate = newSettings.trackUpdate ?? settings.trackUpdate
                settings.userId = newSettings.userId ?? settings.userId
                return settings.save(on: req)
            }
        }
    }
    
    func getFavoriteTracks(_ req: Request) throws -> Future<[FavoriteTrack]> {
        guard let userId: Int = try req.query.get(at: "userId") else { throw Abort(.notFound) }
        return User.find(userId, on: req).flatMap(to: [FavoriteTrack].self)  { user in
            guard let unwrappedUser = user else { throw Abort.init(HTTPStatus.notFound) }
            return try unwrappedUser.favoriteTracks.query(on: req).all()
        }
    }
    
    func removeFavorite(_ req: Request) throws -> Future<HTTPStatus> {
        guard let userId: Int = try req.query.get(at: "userId") else { throw Abort(.notFound) }
        guard let trackId: Int = try req.query.get(at: "trackId") else { throw Abort(.notFound) }
        return FavoriteTrack.query(on: req).filter(\.trackId == trackId).filter(\.userId == userId).first().flatMap { favoriteTracks in
            guard let favorite = favoriteTracks else { throw Abort(.notFound) }
            favorite.delete(on: req)
            return Track.find(trackId, on: req).flatMap { track in
                guard let unwrappedTrack = track else { throw Abort(.notFound) }
                guard let favoritesCount = unwrappedTrack.favoritesCount else { throw Abort(.notFound) }
                unwrappedTrack.favoritesCount = favoritesCount - 1
                return unwrappedTrack.save(on: req).transform(to: .ok)
            }
        }
    }

    
    
}



