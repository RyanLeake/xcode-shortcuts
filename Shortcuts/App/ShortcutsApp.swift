//
//  ShortcutsApp.swift
//  Shortcuts
//
//  Created by Ryan Leake on 22/11/2023.
//

import SwiftUI

@main
struct ShortcutsApp: App {
    var body: some Scene {
        WindowGroup {
            ShortcutsView(viewModel: ViewModel())
        }
    }
}
