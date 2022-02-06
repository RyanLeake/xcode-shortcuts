//
//  ShortcutsApp.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import SwiftUI

@main
struct ShortcutsApp: App {
    var body: some Scene {
        WindowGroup {
            ShortcutsView(viewModel: ShortcutsViewModel())
        }
    }
}
