//
//  VideoLike.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class VideoLike: PostgreSQLModel {
    var id: Int?
    var userId: Int
    var videoId: Int
    
    init(id: Int? = nil,
         userId: Int,
         videoId: Int
        ) {
        self.userId = userId
        self.videoId = videoId
    }
    
}

extension VideoLike: Migration { }

extension VideoLike: Content { }

extension VideoLike: Parameter { }
