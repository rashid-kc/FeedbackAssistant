//
//  PerformanceTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 22/11/23.
//

import XCTest
import CoreData
@testable import FeedbackAssistant

final class PerformanceTests: BaseTestCase {

    func test_awardCalculation_performance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }
        let awards = Array(repeating: Award.allAwards, count: 25).joined()

        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant. Change this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }

    }

}
