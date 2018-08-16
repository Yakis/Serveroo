//
//  FavoriteTrack.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class FavoriteTrack: PostgreSQLModel {
    var id: Int?
    var userId: Int?
    var trackId: Int?
    
    init(id: Int? = nil, userId: Int, trackId: Int) {
        self.userId = userId
        self.trackId = trackId
    }
}

extension FavoriteTrack: Migration { }

extension FavoriteTrack: Content { }

extension FavoriteTrack: Parameter { }
