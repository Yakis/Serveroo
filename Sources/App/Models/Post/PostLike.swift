//
//  PostLike.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class PostLike: PostgreSQLModel {
    var id: Int?
    var userId: Int
    var postId: Int
    
    init(id: Int? = nil,
         userId: Int,
         postId: Int
        ) {
        self.userId = userId
        self.postId = postId
    }

}

extension PostLike: Migration { }

extension PostLike: Content { }

extension PostLike: Parameter { }
