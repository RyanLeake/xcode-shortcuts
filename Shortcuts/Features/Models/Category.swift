//
//  Category.swift
//  Shortcuts
//
//  Created by Ryan Leake on 22/11/2023.
//

import Foundation

/**
 `Category` is an enumeration representing different categories of shortcuts.

 This enum is used to categorize shortcuts in the application, providing a way to filter and organize them based on their type. Each case represents a distinct category of shortcuts.

 - Cases:
    - all: Represents all categories.
    - navigation: A category for navigation-related shortcuts.
    - views: A category for shortcuts related to views.
    - debug: A category for debugging shortcuts.
    - runAndBuild: A category for shortcuts related to running and building projects.
    - testing: A category for shortcuts related to testing.
    - editing: A category for editing-related shortcuts.
    - general: A general category for miscellaneous shortcuts.
*/
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
