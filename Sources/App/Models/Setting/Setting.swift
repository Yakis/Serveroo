//
//  Setting.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Setting: PostgreSQLModel {
    var id: Int?
    var trackUpdate: Bool
    var tagNotify: Bool
    var locationEnabled: Bool
    var userId: Int
    
    init(id: Int? = nil,
         trackUpdate: Bool,
         tagNotify: Bool,
         locationEnabled: Bool,
         userId: Int
        ) {
        self.trackUpdate = trackUpdate
        self.tagNotify = tagNotify
        self.locationEnabled = locationEnabled
        self.userId = userId
    }

}

extension Setting: Migration { }

extension Setting: Content { }

extension Setting: Parameter { }
