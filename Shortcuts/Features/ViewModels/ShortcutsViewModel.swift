//
//  ShortcutsViewModel.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import OSLog
import Combine
import SwiftUI

final class ShortcutsViewModel: ObservableObject {

    // MARK: - Properties

    private let service: ServiceProtocol
    private let logger = Logger()
    private var cancellables = Set<AnyCancellable>()
    private var shortcuts: [Shortcut] = []
    
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

extension ShortcutsViewModel {
    func getShortcuts() {
        service
            .getShortcuts()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.logger.critical("Failed to retrieve shortcuts")
                case .finished:
                    self?.logger.info("Finished fetching shortcuts")
                }
            }, receiveValue: { [weak self] shortcuts in
                self?.shortcuts = shortcuts
                self?.filteredShortcuts = shortcuts
            })
            .store(in: &cancellables)
    }
    
    func toggleFocus(for shortcut: Shortcut) {
        shortcut.toggleFocus()
        filteredShortcuts = filteredShortcuts
    }
}
