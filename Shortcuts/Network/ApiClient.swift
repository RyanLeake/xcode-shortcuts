//
//  ApiClient.swift
//  Shortcuts
//
//  Created by Ryan Leake on 05/02/2022.
//

import Combine
import Foundation

protocol Requestable {
    func request<R: Decodable>(_ endpoint: Endpoint<R>, _ decoder: JSONDecoder) -> AnyPublisher<R, Error>
}

struct ApiClient: Requestable {
    func request<R: Decodable>(_ endpoint: Endpoint<R>, _ decoder: JSONDecoder) -> AnyPublisher<R, Error> {

        guard let request = endpoint.makeRequest() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: R.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
