//
//  Track.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Track: PostgreSQLModel {
    var id: Int?
    var name: String?
    var adress: String?
    var postcode: String?
    var latitude: Double?
    var longitude: Double?
    var soilType: String?
    var openingTimes: String?
    var prices: String?
    var childFriendly: Bool?
    var rating: Double?
    var userId: Int?
    var image: String?
    var featured: Int?
    var favoritesCount: Int?
    
    init(id: Int? = nil,
         name: String,
         adress: String,
         postcode: String,
         latitude: Double,
         longitude: Double,
         soilType: String,
         openingTimes: String,
         prices: String,
         childFriendly: Bool,
         rating: Double,
         userId: Int,
         image: String,
         featured: Int,
         favoritesCount: Int
        ) {
        self.name = name
        self.adress = adress
        self.postcode = postcode
        self.latitude = latitude
        self.longitude = longitude
        self.soilType = soilType
        self.openingTimes = openingTimes
        self.prices = prices
        self.childFriendly = childFriendly
        self.rating = rating
        self.userId = userId
        self.image = image
        self.featured = featured
        self.favoritesCount = favoritesCount
    }
    
}


/// Allows `Track` to be used as a dynamic migration.
extension Track: Migration { }

/// Allows `Track` to be encoded to and decoded from HTTP messages.
extension Track: Content { }

/// Allows `Track` to be used as a dynamic parameter in route definitions.
extension Track: Parameter { }
