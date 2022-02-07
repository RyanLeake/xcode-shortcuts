//
//  ShortcutsViewModel.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import OSLog
import Combine
import SwiftUI

@MainActor
final class ViewModel: ObservableObject {

    // MARK: - Properties

    private let service: ServiceProtocol
    private let logger = Logger()
    private var cancellables = Set<AnyCancellable>()
    private var shortcuts: [Shortcut] = [] {
        didSet {
            filteredShortcuts = shortcuts
        }
    }

    @Published var showFocusedOnly = false {
        didSet {
            filter(nil)
        }
    }
    @Published var filteredShortcuts: [Shortcut] = []

    @Published var filter: Category = Category.all {
        didSet {
            filter(nil)
        }
    }
    var searchText: String = "" {
        didSet {
            filter(searchText)
        }
    }

    init(service: ServiceProtocol = Service()) {
        self.service = service
    }

    private func filter(_ searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            filteredShortcuts = shortcuts.filter {
                (filter == .all || filter.rawValue == $0.category) &&
                (!showFocusedOnly || $0.focused)
            }
            return
        }

        filteredShortcuts = shortcuts.filter {
            $0.description.lowercased().contains(searchText.lowercased()) &&
            (filter == .all || filter.rawValue == $0.category) &&
            (!showFocusedOnly || $0.focused)
        }
    }
}

// MARK: - Inputs

extension ViewModel {
    func getShortcuts() {
        Task {
            do {
                self.shortcuts = try await service
                    .getShortcuts()
            } catch let error {
                logger.error("Failed to retrieve shortcuts: \(error.localizedDescription, privacy: .auto)")
            }
        }
    }

    func toggleFocus(for shortcut: Shortcut) {
        shortcut.toggleFocus()
        filteredShortcuts = filteredShortcuts
    }
}
