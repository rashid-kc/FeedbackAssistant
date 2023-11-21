//
//  IssueViewToolbar.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 21/11/23.
//

import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.string = issue.title
            } label: {
                Label("Copy issue title", systemImage: "doc.on.doc")
            }
            
            Button {
                issue.completed.toggle()
                dataController.save()
            } label: {
                Label(issue.completed ? "Re-open issue": "Close issue", systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
            
            Divider()

            Section("Tags") {
                TagsMenuView(issue: issue)
            }
            
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }
}

#Preview {
    IssueViewToolbar(issue: .example)
        .environmentObject(DataController.preview )
}
