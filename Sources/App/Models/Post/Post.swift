//
//  Post.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Post: PostgreSQLModel {
    var id: Int?
    var content: String?
    var image: String?
    var trackId: Int?
    var userId: Int?
    var trackName: String?
    var trackIcon: String?
    var likesCount: Int?
    var commentsCount: Int?
    
    init(id: Int? = nil,
         content: String,
         image: String,
         trackId: Int,
         userId: Int,
         trackName: String,
         trackIcon: String,
         likesCount: Int,
         commentsCount: Int
        ) {
        self.content = content
        self.image = image
        self.trackId = trackId
        self.userId = userId
        self.trackName = trackName
        self.trackIcon = trackIcon
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        
    }
    
}


extension Post: Migration { }

extension Post: Content { }

extension Post: Parameter { }
