//
//  ExtensionTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 21/11/23.
//

import XCTest
import CoreData
@testable import FeedbackAssistant

final class ExtensionTests: BaseTestCase {
    func test_issueTitle_matchesTitle() {
        // Given
        let issue = Issue(context: managedObjectContext)

        // When
        issue.title = "Example issue"

        // Then
        XCTAssertEqual(issue.issueTitle, "Example issue", "Changing title should also change issueTitle")

        // When
        issue.issueTitle = "Updated issue"

        // Then
        XCTAssertEqual(issue.title, "Updated issue", "Changing issueTitle should also change title.")
    }

    func test_issueContent_matchesContent() {
        // Given
        let issue = Issue(context: managedObjectContext)

        // When
        issue.content = "Example content"

        // Then
        XCTAssertEqual(issue.issueContent, "Example content", "Changing content should also change issueContent")

        // When
        issue.issueContent = "Updated content"

        // Then
        XCTAssertEqual(issue.content, "Updated content", "Changing issueContent should also change content.")
    }

    func test_issueCreationDate_marchesCreationDate() {
        let issue = Issue(context: managedObjectContext)
        let date = Date.now
        issue.creationDate = date

        XCTAssertEqual(issue.issueCreationDate, date, "Changing creationDate should also change issueCreationDate")
    }

    func test_issueTags_works() {
        // Given
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        XCTAssertEqual(issue.issueTags.count, 0, "A new issue should have no tags.")

        // When
        issue.addToTags(tag)

        // Then
        XCTAssertEqual(issue.issueTags.count, 1, "Adding tag should make issueTags count to 1")
    }

    func test_issueTagsList_returnsList() {
        // Given
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        // When
        tag.name = "My Tag"
        issue.addToTags(tag)

        // Then
        XCTAssertEqual(issue.issueTagsList, "My Tag", "Adding 1 tag to an issue should make issueTagsList be My Tag.")
    }

    func test_issueSorting_isStable() {
        // Given
        let issue1 = Issue(context: managedObjectContext)
        issue1.title = "B Issue"
        issue1.creationDate = .now

        let issue2 = Issue(context: managedObjectContext)
        issue2.title = "B Issue"
        issue2.creationDate = .now.addingTimeInterval(1)

        let issue3 = Issue(context: managedObjectContext)
        issue3.title = "A Issue"
        issue3.creationDate = .now.addingTimeInterval(100)

        // When
        let allIssues = [issue1, issue2, issue3]
        let sorted = allIssues.sorted()

        // Then
        XCTAssertEqual([issue3, issue1, issue2], sorted, "Sorting issue arrays should use name then creation date.")
    }

    func test_tagID_matchesID() {
        // Given
        let tag = Tag(context: managedObjectContext)

        // When
        tag.id = UUID()

        // Then
        XCTAssertEqual(tag.tagID, tag.id, "Changing id should also change tagID.")
    }

    func test_tagName_matchesName() {
        // Given
        let tag = Tag(context: managedObjectContext)

        // When
        tag.name = "Sample tag"

        // Then
        XCTAssertEqual(tag.tagName, "Sample tag", "Changing name should also change tagName.")
    }

    func test_tagActiveIssues_returnsActiveIssues() {
        // Given
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        XCTAssertEqual(tag.tagActiveIssues.count, 0, "A new tag should have 0 active issues.")

        // When
        tag.addToIssues(issue)

        // Then
        XCTAssertEqual(tag.tagActiveIssues.count, 1, "A new tag with 1 new issue should have 1 active issue.")

        // When
        issue.completed = true

        // Then
        XCTAssertEqual(tag.tagActiveIssues.count, 0, "A new tag with 1 completed issue should have 0 active issues.")
    }

    func test_tagSorting_isStable() {
        // Given
        let tag1 = Tag(context: managedObjectContext)
        tag1.name = "B Tag"
        tag1.id = UUID()

        let tag2 = Tag(context: managedObjectContext)
        tag2.name = "B Tag"
        tag2.id = UUID(uuidString: "FFFFFFFF-DC22-4463-8C69-7275D037C13D")

        let tag3 = Tag(context: managedObjectContext)
        tag3.name = "A Tag"
        tag3.id = UUID()

        // When
        let allTags = [tag1, tag2, tag3]
        let sortedTags = allTags.sorted()

        // Then
        XCTAssertEqual([tag3, tag1, tag2], sortedTags, "Sorting tag arrays should use name then UUID string.")
    }

    func test_bundleDecodingAwards() {
        let awards = Bundle.main.decode("Awards.json", as: [Award].self)
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }

    func test_decodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableString.json", as: String.self)
        XCTAssertEqual(data, "Never ask a starfish for directions.", "The string must match DecodableString.json.")
    }

    func test_decodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableDictionary.json", as: [String: Int].self)
        XCTAssertEqual(data.count, 3, "There should be three items decoded from DecodableDictionary.json.")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain the value 1 for the key One.")
    }
}
