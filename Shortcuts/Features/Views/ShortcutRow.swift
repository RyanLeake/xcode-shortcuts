//
//  ShortcutRow.swift
//  Shortcuts
//
//  Created by Ryan Leake on 22/11/2023.
//

import SwiftUI

/**
 `ShortcutRow` is a SwiftUI view component designed to display a single shortcut.

 This view is used to represent a shortcut with its description and associated keys in the UI. It supports dynamic updates through a binding to a `Shortcut` model.

 - Parameters:
    - shortcut: A `Binding` to a `Shortcut` model that this row represents.
 */

struct ShortcutRow: View {
    @Binding var shortcut: Shortcut

    var body: some View {
        HStack(spacing: Constants.ShortcutRow.spacing) {
            Text(shortcut.description)
                .accessibilityIdentifier("ShortcutRow_Description_\(shortcut.id)")
                .opacity(Constants.ShortcutRow.descriptionOpacity)
            Spacer()
            ForEach(shortcut.keys.indices, id: \.self) { index in
                let key = shortcut.keys[index]
                KeyView(key: key, color: shortcut.focused ? .accentColor : .text)
                    .accessibilityIdentifier("ShortcutRow_Key_\(shortcut.id)_\(index)")
            }
        }
        .accessibilityIdentifier("ShortcutRow_\(shortcut.id)")
        .padding()
    }
}

struct ShortcutsRow_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutRow(shortcut: .constant(Shortcut.example))
    }
}
