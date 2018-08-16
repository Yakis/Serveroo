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
    var username: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var contactNumber: String?
    var postcode: String?
    var avatar: String?
    var deviceToken: String?
    var firebaseUid: String?
    var userType: String?
    
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

// Parent of:
extension User {
    
    var tracks: Children<User, Track> {
        return children(\.userId)
    }
    
    var tokens: Children<User, UserToken> {
        return children(\.userId)
    }
    
    
//    var reviewComments: Children<User, ReviewComment> {
//        return children()
//    }
//
//
//    var settings: Children<User, Setting> {
//        return children()
//    }
//
//    var postComments: Children<User, PostComment> {
//        return children()
//    }
//
//    var postReply: Children<User, PostReply> {
//        return children()
//    }
//
//    var postLike: Children<User, PostLike> {
//        return children()
//    }
//
//
//    var favoriteTracks: Children<User, FavoriteTrack> {
//        return children()
//    }
//
//
//    var imageComments: Children<User, ImageComment> {
//        return children()
//    }
//
//    var imageReply: Children<User, ImageReply> {
//        return children()
//    }
//
//    var imageLike: Children<User, ImageLike> {
//        return children()
//    }
//
//
//
//    var videoComments: Children<User, VideoComment> {
//        return children()
//    }
//
//    var videoReply: Children<User, VideoReply> {
//        return children()
//    }
//
//    var videoLike: Children<User, VideoLike> {
//        return children()
//    }
//
//
//
//    var reviewReply: Children<User, ReviewReply> {
//        return children()
}
