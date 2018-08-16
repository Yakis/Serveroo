//
//  PostReply.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class PostReply: PostgreSQLModel {
    var id: Int?
    var content: String
    var postCommentId: Int
    var userId: Int
    
    init(id: Int? = nil,
         content: String,
         postCommentId: Int,
         userId: Int
        ) {
        self.content = content
        self.postCommentId = postCommentId
        self.userId = userId
        
    }

}

extension PostReply: Migration { }

extension PostReply: Content { }

extension PostReply: Parameter { }
