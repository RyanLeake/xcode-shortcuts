//
//  Service.swift
//  Shortcuts
//
//  Created by Ryan Leake on 22/11/2023.
//

import Combine
import Foundation

/**
 `ServiceProtocol` defines a protocol for a service that fetches shortcut data.

 This protocol is used to abstract the implementation details of how shortcuts are fetched, allowing for easy mocking or swapping of different data fetching implementations.
 */

protocol ServiceProtocol {
    func getShortcuts() async throws -> [Shortcut]
}

/**
 `Service` is a struct that conforms to `ServiceProtocol`.

 It provides an implementation of the `getShortcuts` method, fetching shortcut data from a local JSON file included in the app bundle.
 */

struct Service: ServiceProtocol {
    func getShortcuts() async throws -> [Shortcut] {
        guard let url = Bundle.main.url(
            forResource: "shortcuts_response",
            withExtension: "json"
        ) else {
            print("Shortcuts JSON file not found.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let shortcuts = try decoder.decode([Shortcut].self, from: data)
            return shortcuts
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}
