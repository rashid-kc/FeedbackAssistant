//
//  ContentView.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 19/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            . onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(text: $viewModel.filterText, prompt: "Filter issues")
        .toolbar(content: ContentViewToolbar.init)
    }
}

#Preview {
    ContentView(dataController: .preview)
}
