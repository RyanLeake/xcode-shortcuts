//
//  MockApiClient.swift
//  ShortcutsTests
//
//  Created by Ryan Leake on 07/02/2022.
//

import Combine
import Foundation

@testable import Shortcuts
struct MockApiClient: Requestable {
    var data: Data

    func request<R>(_ endpoint: Endpoint<R>) async throws -> R {
        return try JSONDecoder().decode(R.self, from: data)
    }
}
