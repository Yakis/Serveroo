//
//  ReviewReply.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class ReviewReply: PostgreSQLModel {
    var id: Int?
    var content: String
    var reviewCommentId: Int
    
    init(id: Int? = nil,
         content: String,
         reviewCommentId: Int
        ) {
        self.content = content
        self.reviewCommentId = reviewCommentId
        
    }

}

extension ReviewReply: Migration { }

extension ReviewReply: Content { }

extension ReviewReply: Parameter { }
