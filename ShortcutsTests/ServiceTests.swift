//
//  ServiceTests.swift
//  ShortcutsTests
//
//  Created by Ryan Leake on 07/02/2022.
//

import XCTest

@testable import Shortcuts
class ServiceTests: XCTestCase {
    private var sut: ServiceProtocol?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetShortcuts() async throws {
        guard let stub = loadStub(name: "shortcuts_response") else {
            XCTFail("Failed to load stub")
            return
        }
        let sut = Service(apiClient: MockApiClient(data: stub))
        let expectedResponse = [Shortcut.example]

        let response = try await sut.getShortcuts()
        XCTAssertEqual(response, expectedResponse)
    }
}
