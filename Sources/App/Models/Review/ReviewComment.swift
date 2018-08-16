//
//  ReviewComment.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class ReviewComment: PostgreSQLModel {
    var id: Int?
    var content: String
    var reviewId: Int
    
    init(id: Int? = nil,
         content: String,
         reviewId: Int
        ) {
        self.content = content
        self.reviewId = reviewId
        
    }
    
}

extension ReviewComment: Migration { }

extension ReviewComment: Content { }

extension ReviewComment: Parameter { }
