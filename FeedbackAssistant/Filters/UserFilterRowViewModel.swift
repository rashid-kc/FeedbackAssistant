//
//  UserFilterRowViewModel.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 25/11/23.
//

import Foundation

extension UserFilterRow {
    @dynamicMemberLookup
    class ViewModel: ObservableObject {
        var tag: Tag

        var tagFilter: Filter {
            Filter(id: tag.tagID, name: tag.tagName, icon: "tag", tag: tag)
        }

        init(tag: Tag) {
            self.tag = tag
        }

        subscript<Value>(dynamicMember keyPath: KeyPath<Filter, Value>) -> Value {
            tagFilter[keyPath: keyPath]
        }
    }
}
