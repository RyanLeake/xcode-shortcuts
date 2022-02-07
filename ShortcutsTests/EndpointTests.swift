//
//  EndpointTests.swift
//  ShortcutsTests
//
//  Created by Ryan Leake on 07/02/2022.
//

import XCTest

@testable import Shortcuts
class EndpointTests: XCTestCase {
    typealias StubbedEndpoint = Endpoint<String>

    func testBasicRequestGeneration() throws {
        let endpoint = StubbedEndpoint(path: "path")
        let request = try XCTUnwrap(endpoint.makeRequest())
        XCTAssertEqual(request.url, URL(string: "https://swifted.io/path"))
    }

    func testRequestGenerationWithQuery() throws {
        let endpoint = StubbedEndpoint(path: "path", query: "query")
        let request = try XCTUnwrap(endpoint.makeRequest())
        XCTAssertEqual(request.url, URL(string: "https://swifted.io/path/query"))
    }
}
