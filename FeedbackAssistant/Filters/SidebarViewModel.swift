//
//  SidebarViewModel.swift
//  FeedbackAssistant
//
//  Created by Rashid KC on 24/11/23.
//

import Foundation
import CoreData

extension SidebarView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        var dataController: DataController

        private let tagsController: NSFetchedResultsController<Tag>
        @Published var tags = [Tag]()

        @Published var tagToRename: Tag?
        @Published var renamingTag = false
        @Published var tagName = ""

        init(dataController: DataController) {
            self.dataController = dataController

            let request = Tag.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.name, ascending: true)]

            tagsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)

            super.init()
            tagsController.delegate = self

            do {
                try tagsController.performFetch()
                tags = tagsController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch tags ")
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newTags = controller.fetchedObjects as? [Tag] {
                tags = newTags
            }
        }

        func delete(_ offsets: IndexSet) {
            for offset in offsets {
                let item = tags[offset]
                dataController.delete(item)
            }
        }

        func delete(_ filter: Filter) {
            guard let tag = filter.tag else { return }
            dataController.delete(tag)
            dataController.save()
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
}
