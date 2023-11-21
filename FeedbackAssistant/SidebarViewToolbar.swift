//
//  SidebarViewToolbar.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 21/11/23.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingAwards = false
    var body: some View {
        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleData()
        } label: {
            Label("Add samples", systemImage: "flame")
        }
        #endif
        
        Button(action: dataController.newTag) {
            Label("Add tag", systemImage: "plus")
        }
        
        Button {
            showingAwards.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }
        .sheet(isPresented: $showingAwards, content: AwardView.init)
    }
}

#Preview {
    SidebarViewToolbar()
}
