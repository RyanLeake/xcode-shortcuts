//
//  Shortcut.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import Foundation

struct Shortcut: Codable, Identifiable {
    let id: String
    let description: String
    let category: String
    let keys: [String]
    var focused: Bool {
        UserDefaults.standard.bool(forKey: self.id)
    }
}

extension Shortcut {
    func toggleFocus() {
        UserDefaults.standard.set(!self.focused, forKey: self.id)
    }
}

extension Shortcut {
    static let example = Shortcut(id: "1",
                                  description: "Global search",
                                  category: "Navigation",
                                  keys: ["⌘", "⇧", "F"])
}
