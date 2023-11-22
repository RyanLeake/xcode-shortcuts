//
//  ShortcutsViewTests.swift
//  ShortcutsUITests
//
//  Created by Ryan Leake on 07/02/2022.
//

import XCTest

/**
 `UITests` is a subclass of XCTestCase, designed to perform automated UI tests for the iOS application.

 This class initializes an instance of `XCUIApplication` and provides a suite of tests to verify the UI's initial state and search functionality within the app.

 - Properties:
    - app: An instance of `XCUIApplication` representing the application under test.
 */

final class UITests: XCTestCase {
    var app: XCUIApplication!

    /**
      Sets up the testing environment before each test method in a test case is called.

      This method initializes the `app` property and configures it to start in a testing state. It ensures the app launches with specific arguments and that each test continues after failures.
     */

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }

    /**
      Tests the initial state of the app's UI.

      This method verifies that the navigation bar for 'Shortcuts' is properly displayed,
     including specific UI elements like a button labeled 'Filter' and a search field with placeholder text 'Search for a shortcut'.
     */

    func testInitialState() {
        XCTAssert(app.navigationBars["Shortcuts"].staticTexts["Shortcuts"].exists)
        XCTAssert(app.navigationBars["Shortcuts"].buttons["Filter"].exists)
        XCTAssert(app.navigationBars["Shortcuts"].searchFields["Search for a shortcut"].exists)
    }
}
