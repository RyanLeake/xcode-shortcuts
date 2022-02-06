//
//  ContentView.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import SwiftUI

struct ShortcutsView: View {
    @ObservedObject private var viewModel: ShortcutsViewModel
    
    init(viewModel: ShortcutsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List($viewModel.filteredShortcuts) { $shortcut in
                ShortcutRow(shortcut: $shortcut)
                    .contextMenu {
                        Button("Toggle focus") {
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
            .searchable(text: $viewModel.searchText, prompt: "shortcuts-search-prompt")
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
                            Label("Focused only", systemImage: "star.fill")
                        }
                    } label: {
                        Label("item-label", systemImage: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutsView(viewModel: ShortcutsViewModel())
    }
}
