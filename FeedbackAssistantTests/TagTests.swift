//
//  TagTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 21/11/23.
//

import XCTest
import CoreData
@testable import FeedbackAssistant

final class TagTests: BaseTestCase {

    func test_creatingTagAndIssues() {
        // Given
        let count = 10
        let issueCount = count * count

        // When
        for _ in 0..<count {
            let tag = Tag(context: managedObjectContext)

            for _ in 0..<count {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        //Then
        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), count, "Expected \(count) tags")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), issueCount, "Expected \(issueCount) issues")
    }

    func test_deletingTag_doesNotDeleteIssues() throws {
        // Given
        dataController.createSampleData()
        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try managedObjectContext.fetch(request)

        // When
        dataController.delete(tags[0])

        // Then
        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 4, "Expected 4 tags after deleting 1")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "Expected 50 issues after deleting a tag")
    }
}
