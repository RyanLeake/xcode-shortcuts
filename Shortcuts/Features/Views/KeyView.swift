//
//  KeyView.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import SwiftUI


/**
 `KeyView` is a SwiftUI view component designed to display a single key.

 This view is primarily used for showing keyboard keys or similar elements in the UI, with customizable text and color.

 - Parameters:
    - key: A `String` representing the key value to be displayed.
    - color: A `Color` for the text of the key. It defaults to `.text`.
*/

struct KeyView: View {
    typealias Constant = Constants.Key

    var key: String
    var color: Color = .text

    var body: some View {
        Text(key)
            .fontWeight(Constants.Key.fontWeight)
            .font(.system(size: Constants.Key.fontSize))
            .frame(width: Constant.dimensions,
                   height: Constant.dimensions,
                   alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: Constant.cornerRadius)
                    .stroke(lineWidth: Constant.borderWidth)
            )
            .foregroundColor(color)
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView(key: "K")
    }
}
