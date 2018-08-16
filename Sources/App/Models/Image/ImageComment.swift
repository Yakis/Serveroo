//
//  ImageComment.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class ImageComment: PostgreSQLModel {
    var id: Int?
    var content: String
    var imageId: Int
    
    init(id: Int? = nil,
         content: String,
         imageId: Int
        ) {
        self.content = content
        self.imageId = imageId
    }

}

extension ImageComment: Migration { }

extension ImageComment: Content { }

extension ImageComment: Parameter { }

extension ImageComment {
    
    var replies: Children<ImageComment, ImageReply> {
        return children(\.imageCommentId)
    }
    
    
}
