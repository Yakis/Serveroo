//
//  AdvertMessage.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class AdvertMessage: PostgreSQLModel {
    var id: Int?
    var content: String?
    var advertId: Int?
    var userId: Int?
    
    init(id: Int? = nil,
         content: String,
         advertId: Int,
         userId: Int
        ) {
        self.content = content
        self.userId = userId
        
    }
    
}

extension AdvertMessage: Migration { }

extension AdvertMessage: Content { }

extension AdvertMessage: Parameter { }
