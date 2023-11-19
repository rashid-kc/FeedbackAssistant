//
//  Filter.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 19/11/23.
//

import Foundation

struct Filter: Identifiable, Hashable {
    let id: UUID
    var name: String
    var icon: String
    var minModificationDate = Date.distantPast
    var tag: Tag?
    
    static var all = Filter(id: UUID(), name: "All issues", icon: "tray")
    static var recent = Filter(id: UUID(), name: "Recent", icon: "clock", minModificationDate: .now.addingTimeInterval(86400 * -7))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
