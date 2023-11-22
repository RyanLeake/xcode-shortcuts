//
//  ShortcutsViewModel.swift
//  Shortcuts
//
//  Created by Ryan Leake on 22/11/2023.
//

import Combine
import OSLog
import SwiftUI

/**
 `ViewModel` is a SwiftUI and Combine-based observable object that manages the state and logic for a shortcuts application.

 This class is responsible for fetching, filtering, and managing the state of shortcuts. It communicates with a service layer to retrieve data and provides filtered views of this data to the UI.

 - Parameters:
    - service: An instance of `ServiceProtocol` used for fetching shortcut data.
    - logger: A logger instance for logging events and errors.
    - cancellables: A set of AnyCancellable for managing Combine subscriptions.
    - shortcuts: An array of `Shortcut` objects, serving as the source of truth for shortcut data.
    - showFocusedOnly: A Boolean indicating whether to show only focused shortcuts.
    - filteredShortcuts: An array of `Shortcut` objects that represents the currently filtered view of shortcuts.
    - filter: A `Category` value used to filter shortcuts based on their category.
    - searchText: A string used for filtering shortcuts based on their description.
 */

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

    @Published var filter: Category = .all {
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

    // MARK: - Filtering Logic

    private func filter(_ searchText: String?) {
        // Filter logic based on search text, category filter, and focus status.

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
    /**
      Fetches shortcuts from the service and updates the `shortcuts` array.

      This function asynchronously fetches shortcut data, sorts it, and handles any errors that may occur during fetching.
     */
    func getShortcuts() {
        Task {
            do {
                self.shortcuts = try await service
                    .getShortcuts()
                    .sorted { $0.description < $1.description }
            } catch {
                logger.error("Failed to retrieve shortcuts: \(error.localizedDescription, privacy: .auto)")
            }
        }
    }

    /**
      Toggles the focus state of a given shortcut and updates the filtered shortcuts.

      - Parameters:
         - shortcut: The `Shortcut` object for which the focus state is to be toggled.
     */
    func toggleFocus(for shortcut: Shortcut) {
        shortcut.toggleFocus()
        filteredShortcuts = filteredShortcuts
    }
}
