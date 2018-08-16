//
//  PostComment.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class PostComment: PostgreSQLModel {
    var id: Int?
    var content: String
    var postId: Int
    var userId: Int
    
    init(id: Int? = nil,
         content: String,
         postId: Int,
         userId: Int
        ) {
        self.content = content
        self.postId = postId
        self.userId = userId
        
    }

}

extension PostComment: Migration { }

extension PostComment: Content { }

extension PostComment: Parameter { }
