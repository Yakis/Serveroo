//
//  TracksController.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor
import FluentSQL


final class TracksController: RouteCollection {
    
    
    func boot(router: Router) throws {
        let tracks = router.grouped("tracks")
        
        // /tracks/create
        tracks.post("create", use: create)
        
        // /tracks/all
        tracks.get("all", use: getAll)
        
        // /tracks/:id
        tracks.get(Track.parameter, use: getOne)
        tracks.patch(Track.parameter, use: update)
        tracks.delete(Track.parameter, use: delete)
        
        // /tracks/search?name=:name
        tracks.get("search", use: searchByName)
        
        // /tracks?userId=1
        tracks.get("", use: getByOwner)
        
        // /api/v1/tracks/:id/images
        tracks.get(Track.parameter, "images", use: getImages)
        
        // /tracks/favorites/create
        tracks.post("favorites", "create", use: setFavoriteTrack)
        
        /*
        // /api/v1/tracks/favorites?user_id=1
        routeBuilder.get("favorites", handler: getFavoriteTracks)
        
        // /api/v1/tracks/favorites/create
        routeBuilder.post("favorites", "create", handler: setFavorite)
        
        // /api/v1/tracks/favorites?user_id=1&track_id=1
        routeBuilder.delete("favorites", handler: removeFavorite)
        
        // /api/v1/tracks/favs?user_id=1
        routeBuilder.get("favs", handler: getFavoritesForUser)
        */
    }
    
    
    func getAll(_ req: Request) throws -> Future<[Track]> {
        return Track.query(on: req).all()
    }
    
    
    func getOne(_ req: Request) throws -> Future<Track> {
        return try req.parameters.next(Track.self)
    }
    
    
    func create(_ req: Request) throws -> Future<Track> {
        return try req.content.decode(Track.self).flatMap { track in
            return track.save(on: req)
        }
    }
    
    
    func update(_ req: Request) throws -> Future<Track> {
        return try req.parameters.next(Track.self).flatMap { track in
            return try req.content.decode(Track.self).flatMap { newTrack in
                track.name = newTrack.name ?? track.name
                track.adress = newTrack.adress ?? track.adress
                track.postcode = newTrack.postcode ?? track.postcode
                track.latitude = newTrack.latitude ?? track.latitude
                track.longitude = newTrack.longitude ?? track.longitude
                track.soilType = newTrack.soilType ?? track.soilType
                track.openingTimes = newTrack.openingTimes ?? track.openingTimes
                track.prices = newTrack.prices ?? track.prices
                track.childFriendly = newTrack.childFriendly ?? track.childFriendly
                track.rating = newTrack.rating ?? track.rating
                track.userId = newTrack.userId ?? track.userId
                track.image = newTrack.image ?? track.image
                track.featured = newTrack.featured ?? track.featured
                track.favoritesCount = newTrack.favoritesCount ?? track.favoritesCount
                return track.save(on: req)
            }
        }
    }
    
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap { user in
            return user.delete(on: req)
            }.transform(to: .ok)
    }


    func searchByName(_ req: Request) throws -> Future<[Track]> {
        guard let searchedName: String = try req.query.get(at: "name") else {
            throw Abort(.badRequest)
        }
        return try Track.query(on: req).filter(\Track.name ~~ searchedName).all()
    }
    
    
//    func getByOwner(_ req: Request) throws -> Future<[Track]> {
//        return try req.parameters.next(User.self).flatMap({ user in
//            return try user.tracks.query(on: req).all()
//        })
//    }
    
    
    func getByOwner(_ req: Request) throws -> Future<[Track]> {
        guard let userId: Int = try req.query.get(at: "userId") else {
            throw Abort(.badRequest)
        }
        return try Track.query(on: req).filter(\Track.userId == userId).all()
    }
    
    
    func getImages(_ req: Request) throws -> Future<[Image]> {
        return try req.parameters.next(Track.self).flatMap { track in
            return try track.images.query(on: req).all()
        }
    }
    
    
    func setFavoriteTrack(_ req: Request) throws -> Future<Track> {
        return try req.content.decode(FavoriteTrack.self).flatMap { favoriteTrack in
            guard let trackId = favoriteTrack.trackId else { throw Abort.init(HTTPStatus.notFound) }
            return try Track.find(trackId, on: req).flatMap(to: Track.self, { track in
                favoriteTrack.save(on: req)
                let favoritesCount = track?.favoritesCount ?? 0
                track?.favoritesCount = favoritesCount + 1
                return (track?.save(on: req))!
                
            })
        }
    }
    
    
    
}
