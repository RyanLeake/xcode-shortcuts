//
//  Endpoint.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import Foundation

struct Endpoint<Response: Decodable> {
    var path: String
    var query: String?
}

extension Endpoint {
    func makeRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "swifted.io"
        components.path = "/" + path
        if let query = query {
            components.path +=  "/" + query
        }

        guard let url = components.url else {
            return nil
        }

        let request = URLRequest(url: url)
        return request
    }
}

extension Endpoint where Response == [Shortcut] {
    static var shortcuts: Self {
        Endpoint(path: "json/shortcuts.json")
    }
}
