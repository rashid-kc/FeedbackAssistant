//
//  SidebarView.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 19/11/23.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    
    @State private var tagToRename: Tag?
    @State private var renamingTag = false
    @State private var tagName = ""
    
    var tagFilters: [Filter] {
        tags.map { tag in
            Filter(id: tag.tagID, name: tag.tagName, icon: "tag", tag: tag)
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart filters") {
                ForEach(smartFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
            
            Section("Tags") {
                ForEach(tagFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                            .badge(filter.tag?.tagActiveIssues.count ?? 0)
                            .contextMenu {
                                Button {
                                    rename(filter)
                                } label: {
                                    Label("Rename", systemImage: "pencil")
                                }
                            }
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .toolbar {
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
        }
        .alert("Rename tag", isPresented: $renamingTag) {
            Button("OK", action: completeRename)
            Button("Cancel", role: .cancel) { }
            TextField("New name", text: $tagName)
        }
    }
    
    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let item = tags[offset]
            dataController.delete(item)
        }
    }
    
    func rename(_ filter: Filter) {
        tagToRename = filter.tag
        tagName = filter.name
        renamingTag = true
    }
    
    func completeRename() {
        tagToRename?.name = tagName
        dataController.save()
    }
}

#Preview {
    SidebarView()
        .environmentObject(DataController.preview)
}
