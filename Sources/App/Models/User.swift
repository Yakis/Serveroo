//
//  User.swift
//  App
//
//  Created by Mugurel Moscaliuc on 28/05/2018.
//

import FluentPostgreSQL
import Vapor


final class User: PostgreSQLModel {
    
    var id: Int?
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var contactNumber: String
    var postcode: String
    var avatar: String
    var deviceToken: String
    var firebaseUid: String
    var userType: String
    
    init(id: Int? = nil, username: String,
         email: String,
         firstName: String,
         lastName: String,
         contactNumber: String,
         postcode: String,
         avatar: String,
         deviceToken: String,
         firebaseUid: String,
         userType: String
        ) {
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.postcode = postcode
        self.avatar = avatar
        self.deviceToken = deviceToken
        self.firebaseUid = firebaseUid
        self.contactNumber = contactNumber
        self.userType = userType
        
    }
    
}


/// Allows `User` to be used as a dynamic migration.
extension User: Migration { }

/// Allows `User` to be encoded to and decoded from HTTP messages.
extension User: Content { }

/// Allows `User` to be used as a dynamic parameter in route definitions.
extension User: Parameter { }
