//
//  FeedbackAssistantTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 21/11/23.
//

import XCTest
import CoreData
@testable import FeedbackAssistant

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
