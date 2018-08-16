//
//  ImageLike.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class ImageLike: PostgreSQLModel {
    var id: Int?
    var userId: Int
    var imageId: Int
    
    init(id: Int? = nil,
         userId: Int,
         imageId: Int
        ) {
        self.userId = userId
        self.imageId = imageId
    }

}

extension ImageLike: Migration { }

extension ImageLike: Content { }

extension ImageLike: Parameter { }
