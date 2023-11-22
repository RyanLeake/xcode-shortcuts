//
//  Shortcut.swift
//  Shortcuts
//
//  Created by Ryan Leake on 22/11/2023.
//

import Foundation

/**
 `Shortcut` is a struct representing a keyboard shortcut or a similar command.

 It encapsulates the data associated with a specific shortcut, including its unique identifier, description, category, and associated keys.

 - Parameters:
    - id: A unique identifier for the shortcut.
    - description: A human-readable description of what the shortcut does.
    - category: A string representing the category of the shortcut.
    - keys: An array of strings representing the keys involved in the shortcut.
    - focused: A Boolean value indicating whether the shortcut is marked as focused by the user. This is stored in `UserDefaults`.
 */

struct Shortcut: Codable, Identifiable, Equatable {
    let id: String
    let description: String
    let category: String
    let keys: [String]
    var focused: Bool {
        UserDefaults.standard.bool(forKey: self.id)
    }
}

extension Shortcut {
    /**
      Toggles the focus state of the shortcut.

      This method updates the focus state of the shortcut in `UserDefaults`, effectively persisting the change across app sessions.
     */

    func toggleFocus() {
        UserDefaults.standard.set(!self.focused, forKey: self.id)
    }
}

extension Shortcut {
    /**
     Provides an example `Shortcut` instance for demonstration or testing purposes.

     This static property is particularly useful in previews or during development to provide a concrete instance with sample data.
     */

    static let example = Shortcut(
        id: "1",
        description: "Jump to another editor",
        category: "Navigation",
        keys: ["⌘", "J"]
    )
}
