//
//  ImageReply.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class ImageReply: PostgreSQLModel {
    var id: Int?
    var content: String
    var imageCommentId: Int
    
    init(id: Int? = nil,
         content: String,
         imageCommentId: Int
        ) {
        self.content = content
        self.imageCommentId = imageCommentId
        
    }

}

extension ImageReply: Migration { }

extension ImageReply: Content { }

extension ImageReply: Parameter { }
