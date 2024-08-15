//
//  RemoteRepository.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Combine
import Foundation

protocol RemoteRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension RemoteRepository {
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error>
        where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
