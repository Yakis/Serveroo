//
//  AdvertImage.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class AdvertImage: PostgreSQLModel {
    var id: Int?
    var imageUrl: String
    var advertId: Int
    
    init(id: Int? = nil,
         imageUrl: String,
         advertId: Int
        ) {
        self.imageUrl = imageUrl
        self.advertId = advertId
        
    }
    
}

extension AdvertImage: Migration { }

extension AdvertImage: Content { }

extension AdvertImage: Parameter { }
