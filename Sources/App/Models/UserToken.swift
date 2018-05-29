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
    var user_id: Int
    
    init(id: Int? = nil, token: String, user_id: Int) {
        self.id = id
        self.token = token
        self.user_id = user_id
    }
    
}


extension UserToken: Migration {}

extension UserToken: Content {}

extension UserToken: Parameter {}
