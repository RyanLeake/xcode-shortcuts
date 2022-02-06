//
//  ShortcutRow.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import SwiftUI

struct ShortcutRow: View {
   @Binding var shortcut: Shortcut

    var body: some View {
        HStack(spacing: Constants.ShortcutRow.spacing) {
            Text(shortcut.description)
                .opacity(Constants.ShortcutRow.descriptionOpacity)
            Spacer()
            ForEach(shortcut.keys, id: \.self) { key in
                KeyView(key: key, color: shortcut.focused ? .accentColor : .text)
            }
        }
        .padding()
    }
}
