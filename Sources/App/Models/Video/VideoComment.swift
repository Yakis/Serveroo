//
//  VideoComment.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class VideoComment: PostgreSQLModel {
    var id: Int?
    var content: String
    var videoId: Int
    
    init(id: Int? = nil,
         content: String,
         videoId: Int
        ) {
        self.content = content
        self.videoId = videoId
    }
    
}

extension VideoComment: Migration { }

extension VideoComment: Content { }

extension VideoComment: Parameter { }
