//
//  Image.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Image: PostgreSQLModel {
    var id: Int?
    var imageUrl: String
    var trackId: Int

    init(id: Int? = nil,
         imageUrl: String,
         trackId: Int
        ) {
        self.imageUrl = imageUrl
        self.trackId = trackId
    }
}

extension Image: Migration { }

extension Image: Content { }

extension Image: Parameter { }

extension Image {
    
    var comments: Children<Image, ImageComment> {
        return children(\.imageId)
    }
    
    
    var likes: Children<Image, ImageLike> {
        return children(\.imageId)
    }
    
}
