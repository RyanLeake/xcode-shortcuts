//
//  ShortcutsViewModelTests.swift
//  ShortcutsTests
//
//  Created by Ryan Leake on 07/02/2022.
//

import XCTest
import Combine
import Foundation

@testable import Shortcuts

class ViewModelTests: XCTestCase {
    private var sut: ViewModel?
    private var cancellables = Set<AnyCancellable>()

    @MainActor override func setUp() {
        super.setUp()

        guard let stub = loadStub(name: "shortcuts_response") else {
            XCTFail("Failed to load stub")
            return
        }

        let expectation = XCTestExpectation(description: "Array of 'Shortcut' objects returned")

        sut = ViewModel(service: Service(apiClient: MockApiClient(data: stub)))

        sut?.$filteredShortcuts
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { shortcuts in
                XCTAssert(shortcuts.count > 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut?.getShortcuts()
        wait(for: [expectation], timeout: 1)
    }

    override func tearDown() {
        sut = nil
        cancellables = []
        super.tearDown()
    }

    @MainActor func testShowFocusedOnly() {
        sut?.showFocusedOnly = true

        if Shortcut.example.focused {
            XCTAssertEqual(sut?.filteredShortcuts.count, 1)
        } else {
            XCTAssertEqual(sut?.filteredShortcuts.count, 0)
        }
    }

    @MainActor func testFiltering() {
        sut?.filter = .all
        XCTAssertEqual(sut?.filteredShortcuts.count, 1)
        sut?.filter = .editing
        XCTAssertEqual(sut?.filteredShortcuts.count, 0)
        sut?.filter = .navigation
        XCTAssertEqual(sut?.filteredShortcuts.count, 1)
    }

    @MainActor func testSearchQuery() {
        sut?.searchText = "Jump"
        XCTAssertEqual(sut?.filteredShortcuts.count, 1)
        sut?.searchText = "Indent"
        XCTAssertEqual(sut?.filteredShortcuts.count, 0)
    }

    @MainActor func testToggleFocus() {
        let focused = Shortcut.example.focused
        sut?.toggleFocus(for: Shortcut.example)
        XCTAssertEqual(!focused, Shortcut.example.focused)
    }
}
