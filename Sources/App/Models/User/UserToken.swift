//
//  UserToken.swift
//  App
//
//  Created by Mugurel Moscaliuc on 28/05/2018.
//

import FluentPostgreSQL
import Vapor

final class UserToken: PostgreSQLModel {
    
    var id: Int?
    var token: String
    var userId: Int
    
    init(id: Int? = nil,
         token: String,
         userId: Int) {
        self.id = id
        self.token = token
        self.userId = userId
    }
    
}


extension UserToken: Migration {}

extension UserToken: Content {}

extension UserToken: Parameter {}
