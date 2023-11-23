//
//  DevelopmentTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 21/11/23.
//

import XCTest
import CoreData
@testable import FeedbackAssistant

final class DevelopmentTests: BaseTestCase {

    func test_sampleDataCreation_works() {
        // When
        dataController.createSampleData()

        // Then
        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should be 50 sample issues.")
    }

    func test_deleteAll_deletesEverything() {
        // When
        dataController.createSampleData()
        dataController.deleteAll()

        // Then
        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "Tags should be cleared")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "Issues should be cleared")
    }

    func test_exampleTag_hasNoIssues() {
        // Given
        let tag = Tag.example

        // Then
        XCTAssertEqual(tag.issues?.count, 0, "The example tag should have 0 issues.")
    }

    func test_exampleIssue_hasPriorityHigh() {
        // Given
        let issue = Issue.example

        // Then
        XCTAssertEqual(issue.priority, 2, "The example issue should be high priority.")
    }
}
