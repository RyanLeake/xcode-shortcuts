//
//  Category.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    case all = "All"
    case navigation = "Navigation"
    case views = "Views"
    case debug = "Debug"
    case runAndBuild = "Run and build"
    case testing = "Testing"
    case editing = "Editing"
    case general = "General"

    var id: Category { self }
}
