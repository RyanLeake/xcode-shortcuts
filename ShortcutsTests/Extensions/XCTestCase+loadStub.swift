//
//  XCTestCase+loadStub.swift
//  ShortcutsTests
//
//  Created by Ryan Leake on 07/02/2022.
//

import XCTest

extension XCTestCase {
    func loadStub(name: String, extension: String? = "json") -> Data? {
        let bundle = Bundle(for: classForCoder)
        if let url = bundle.url(forResource: name, withExtension: `extension`) {
            let data = try? Data(contentsOf: url)
            return data
        } else {
            return nil
        }
    }
}
