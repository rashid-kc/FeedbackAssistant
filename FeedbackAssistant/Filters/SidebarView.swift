//
//  SidebarView.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 19/11/23.
//

import SwiftUI

struct SidebarView: View {
    @StateObject private var viewModel: ViewModel
    let smartFilters: [Filter] = [.all, .recent]

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.dataController.selectedFilter) {
            Section("Smart filters") {
                ForEach(smartFilters, content: SmartFilterRow.init)
            }

            Section("Tags") {
                ForEach(viewModel.tags) { tag in
                    UserFilterRow(tag: tag, rename: viewModel.rename, delete: viewModel.delete)
                }
                .onDelete(perform: viewModel.delete)
            }
        }
        .toolbar(content: SidebarViewToolbar.init)
        .alert("Rename tag", isPresented: $viewModel.renamingTag) {
            Button("OK", action: viewModel.completeRename)
            Button("Cancel", role: .cancel) { }
            TextField("New name", text: $viewModel.tagName)
        }
        .navigationTitle("Filters")
    }
}

#Preview {
    SidebarView(dataController: .preview)
}
