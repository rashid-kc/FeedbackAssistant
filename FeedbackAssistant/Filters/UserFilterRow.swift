//
//  UserFilterRow.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 21/11/23.
//

import SwiftUI

struct UserFilterRow: View {
    @StateObject var viewModel: ViewModel

    var rename: (Filter) -> Void
    var delete: (Filter) -> Void

    init(tag: Tag, rename: @escaping (Filter) -> Void, delete: @escaping (Filter) -> Void) {
        let viewModel = ViewModel(tag: tag)
        _viewModel = StateObject(wrappedValue: viewModel)
        self.rename = rename
        self.delete = delete
    }

    var body: some View {
        NavigationLink(value: viewModel.tagFilter) {
            Label(viewModel.name, systemImage: viewModel.icon)
                .badge(viewModel.activeIssueCount)
                .contextMenu {
                    Button {
                        rename(viewModel.tagFilter)
                    } label: {
                        Label("Rename", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        delete(viewModel.tagFilter)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .accessibilityElement()
                .accessibilityLabel(viewModel.name)
                .accessibilityHint("\(viewModel.activeIssueCount) issues")
        }
    }
}

#Preview {
    UserFilterRow(tag: .example, rename: { _ in}, delete: { _ in})
}
