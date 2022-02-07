//
//  Service.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func getShortcuts() async throws -> [Shortcut]
}

struct Service: ServiceProtocol {

    private let apiClient: Requestable

    init(apiClient: Requestable = ApiClient()) {
        self.apiClient = apiClient
    }

    func getShortcuts() async throws -> [Shortcut] {
        try await apiClient.request(.shortcuts)
    }
}
