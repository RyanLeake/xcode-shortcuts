//
//  ContentView.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import SwiftUI

/**
 `ShortcutsView` is a SwiftUI view component designed to display a list of shortcuts.

 This view is the primary interface for showing shortcuts, allowing users to interact with them through various UI elements.
 It uses a `ViewModel` as an `@ObservedObject` to react to data changes and user interactions.

 - Parameters:
    - viewModel: An `@ObservedObject` instance of `ViewModel` which provides the data and logic for the view.

 - Note:
    - This view includes a `NavigationView` with a `List` of shortcuts, each represented by a `ShortcutRow`.
    - It supports searching, filtering, and toggling the focus state of shortcuts.
    - UI components like context menus, search bars, and toolbars are used for enhanced user interaction.
 */
struct ShortcutsView: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List($viewModel.filteredShortcuts) { $shortcut in
                ShortcutRow(shortcut: $shortcut)
                    .contextMenu {
                        Button("toggle-focus") {
                            withAnimation {
                                viewModel.toggleFocus(for: shortcut)
                            }
                        }
                    }
            }
            .listStyle(.automatic)
            .onAppear {
                viewModel.getShortcuts()
            }
            .navigationTitle("shortcuts-title")
            .searchable(
                text: $viewModel.searchText,
                prompt: "shortcuts-search-prompt"
            )
            .toolbar {
                ToolbarItem {
                    Menu {
                        Picker("picker-label", selection: $viewModel.filter) {
                            ForEach(Category.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(.inline)

                        Toggle(isOn: $viewModel.showFocusedOnly) {
                            Label("focused-only", systemImage: "target")
                        }
                    } label: {
                        Label("item-label", systemImage: "slider.horizontal.3")
                    }
                }
            }
            .accessibilityIdentifier("shortcutList")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ShortcutsView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutsView(viewModel: ViewModel())
    }
}
