//
//  Video.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Video: PostgreSQLModel {
    var id: Int?
    var videoUrl: String
    var trackId: Int
    
    init(id: Int? = nil,
         videoUrl: String,
         trackId: Int
        ) {
        self.videoUrl = videoUrl
        self.trackId = trackId
    }
}

extension Video: Migration { }

extension Video: Content { }

extension Video: Parameter { }
