//
//  Event.swift
//  App
//
//  Created by Mugurel Moscaliuc on 16/08/2018.
//

import FluentPostgreSQL
import Vapor


final class Event: PostgreSQLModel {
    var id: Int?
    var content: String
    var eventDate: Date
    var trackId: Int

    init(id: Int? = nil,
         content: String,
         eventDate: Date,
         trackId: Int
        ) {
        self.content = content
        self.eventDate = eventDate
        self.trackId = trackId
    }
}

extension Event: Migration { }

extension Event: Content { }

extension Event: Parameter { }
