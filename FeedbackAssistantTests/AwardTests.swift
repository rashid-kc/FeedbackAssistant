//
//  AwardTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 21/11/23.
//

import XCTest
import CoreData
@testable import FeedbackAssistant

final class AwardTests: BaseTestCase {
    let awards = Award.allAwards

    func test_awardID_matchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should match its name")
        }
    }

    func test_newUser_hasNotEarnedAwards() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New user should not have any awards earned")
        }
    }

    func test_creatingIssues_unlockAwards() {
        // Given
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        // When
        for (count, value) in values.enumerated() {
            var issues = [Issue]()

            for _ in 0..<value {
                let issue = Issue(context: managedObjectContext)
                issues.append(issue)
            }

            let matches = awards.filter { award in
                award.criterion == "issues" && dataController.hasEarned(award: award)
            }

            // Then
            XCTAssertEqual(matches.count, count + 1, "Creating \(value) issues should unlock \(count + 1) awards")
            dataController.deleteAll()
        }
    }

    func test_closingIssues_unlockAwards() {
        // Given
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]

        // When
        for (count, value) in values.enumerated() {
            var issues = [Issue]()

            for _ in 0..<value {
                let issue = Issue(context: managedObjectContext)
                issue.completed = true
                issues.append(issue)
            }

            let matches = awards.filter { award in
                award.criterion == "closed" && dataController.hasEarned(award: award)
            }

            // Then
            XCTAssertEqual(matches.count, count + 1, "Closing \(value) issues should unlock \(count + 1) awards")
            dataController.deleteAll()
        }
    }
}
