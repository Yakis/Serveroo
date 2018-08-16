//
//  Advert.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Advert: PostgreSQLModel {
    var id: Int?
    var title: String
    var description: String
    var price: Double
    var userId: Int

    init(id: Int? = nil,
         title: String,
         description: String,
         price: Double,
         userId: Int
        ) {
        self.title = title
        self.description = description
        self.price = price
        self.userId = userId
        
    }
}

extension Advert: Migration { }

extension Advert: Content { }

extension Advert: Parameter { }

extension Advert {
    
    var images: Children<Advert, AdvertImage> {
        return children(\.advertId)
    }
    
    var messages: Children<Advert, AdvertMessage> {
        return children(\.advertId)
    }
    
}
