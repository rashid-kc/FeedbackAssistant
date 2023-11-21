//
//  NoIssueView.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 19/11/23.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        Text("No issue selected")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New issue", action: dataController.newIssue)
    }
}

#Preview {
    NoIssueView()
}
