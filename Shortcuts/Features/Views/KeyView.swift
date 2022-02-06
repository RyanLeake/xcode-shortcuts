//
//  KeyView.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import SwiftUI

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
