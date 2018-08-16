//
//  VideoReply.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class VideoReply: PostgreSQLModel {
    var id: Int?
    var content: String
    var videoCommentId: Int
    
    init(id: Int? = nil,
         content: String,
         videoCommentId: Int
        ) {
        self.content = content
        self.videoCommentId = videoCommentId
        
    }
    
}

extension VideoReply: Migration { }

extension VideoReply: Content { }

extension VideoReply: Parameter { }
