//
//  Review.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Review: PostgreSQLModel {
    var id: Int?
    var stars: Int
    var content: String
    var trackId: Int
    
    init(id: Int? = nil,
         stars: Int,
         content: String,
         trackId: Int
        ) {
        self.stars = stars
        self.content = content
        self.trackId = trackId
        
    }

}

extension Review: Migration { }

extension Review: Content { }

extension Review: Parameter { }
