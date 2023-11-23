//
//  FeedbackAssistantUITests.swift
//  FeedbackAssistantUITests
//
//  Created by Rashid KC on 22/11/23.
//

import XCTest

extension XCUIElement {
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Failed to clear text in XCUIElement.")
            return
        }

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
}

final class FeedbackAssistantUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func test_appStarts_withNavigationBar() throws {
        XCTAssertTrue(app.navigationBars.element.exists, "There should be navigation bar at the time of app launch")
    }

    func test_appStarts_withBasicButtons() throws {
        XCTAssert(app.buttons["Filters"].exists, "There should be Filters button at the time of launch")
        XCTAssert(app.buttons["Filter"].exists, "There should be Filter button at the time of launch")
        XCTAssert(app.buttons["New issue"].exists, "There should be New issue button at the time of launch")
    }

    func test_creatingAndDeleting_issues() {
        for tapCount in 1...5 {
            app.buttons["New issue"].tap()
            app.buttons["Issues"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list")
        }

        for tapCount in (0...4).reversed() {
            app.cells.firstMatch.swipeLeft()
            app.buttons["Delete"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list")
        }
    }

    func test_EditingIssue_updatesCorrectly() {
        XCTAssertEqual(app.cells.count, 0, "There should be no rows initially")

        app.buttons["New issue"].tap()
        app.textFields["Enter the issue title here"].tap()
        app.textFields["Enter the issue title here"].clear()
        app.typeText("My new issue")

        app.buttons["Issues"].tap()
        XCTAssertTrue(app.buttons["My new issue ID"].exists, "A My new issue cell should be there")

    }

    func testEditingIssuePriorityShowsIcon() {
        app.buttons["New issue"].tap()
        app.buttons["Priority, Medium"].tap()
        app.buttons["High"].tap()

        app.buttons["Issues"].tap()

        let identifier = "New issue High priority"
        XCTAssert(app.images[identifier].exists, "A high priority issue needs an icon next to it.")
    }

    func test_allAwards_showLockedAlert() {
        app.buttons["Filters"].tap()
        app.buttons["Show awards"].tap()

        for award in app.scrollViews.buttons.allElementsBoundByIndex {
            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "There should be a Locked alert showing for awards.")
            app.buttons["OK"].tap()
        }
    }

}
