//
//  ShortcutsViewTests.swift
//  ShortcutsUITests
//
//  Created by Ryan Leake on 07/02/2022.
//

import XCTest

final class UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }

    func testInitialState() {
        XCTAssert(app.navigationBars["Shortcuts"].staticTexts["Shortcuts"].exists)
        XCTAssert(app.navigationBars["Shortcuts"].buttons["Filter"].exists)
        XCTAssert(app.navigationBars["Shortcuts"].searchFields["Search for a shortcut"].exists)
        XCTAssert(app.tables["shortcutList"].exists)
    }

    func testSearchFlow() {
        let shortcutsNavigationBar = app.navigationBars["Shortcuts"]
        shortcutsNavigationBar.searchFields["Search for a shortcut"].tap()
        XCTAssert(shortcutsNavigationBar.buttons["Cancel"].exists)
        XCTAssert(app.keyboards.count > 0)
        shortcutsNavigationBar.buttons["Cancel"].tap()
    }
}
