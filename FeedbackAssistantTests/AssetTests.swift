//
//  AssetTests.swift
//  FeedbackAssistantTests
//
//  Created by Rashid KC on 21/11/23.
//

import XCTest
@testable import FeedbackAssistant

final class AssetTests: XCTestCase {

    func test_colorsExist() {
        let allColors = ["AW Dark Blue", "AW Dark Gray", "AW Gold", "AW Gray", "AW Green",
                             "AW Light Blue", "AW Midnight", "AW Orange", "AW Pink", "AW Purple", "AW Red", "AW Teal"]

        for color in allColors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color) from asset catalog.")
        }
    }

    func test_awards_loadCorrectly() {
        XCTAssertTrue(Award.allAwards.isEmpty == false, "Failed to load awards from JSON.")
    }
}
