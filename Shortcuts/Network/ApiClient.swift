//
//  ApiClient.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import Combine
import Foundation

protocol Requestable {
    func request<R: Decodable>(_ endpoint: Endpoint<R>) async throws -> R
}

struct ApiClient: Requestable {
    func request<R: Decodable>(_ endpoint: Endpoint<R>) async throws -> R {
        guard let request = endpoint.makeRequest(), let url = request.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(R.self, from: data)
    }
}
