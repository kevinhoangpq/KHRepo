//
//  Repos.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Combine
import Foundation

private extension Repos {
    enum API {
        case searchByQuery(String)
    }
}

extension Repos.API: APICall {
    var path: String {
        switch self {
        case let .searchByQuery(query):
            return "/search/repositories?q=\(query)"
        }
    }
    
    var method: String {
        return "GET"
    }
        
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
        
    func body() throws -> Data? {
        return nil
    }
}


final class Repos: ReposExpected, RemoteRepository {
    let session: URLSession
    let baseURL: String
    
    init(session: URLSession = .shared, baseURL: String = "https://api.github.com") {
        self.session = session
        self.baseURL = baseURL
    }
    
    func searchRepos(withQuery query: String) -> AnyPublisher<[GitRepo], Error> {
        let apiCaller: AnyPublisher<SearchResponse, Error> = call(endpoint: API.searchByQuery(query))
        return apiCaller.map { $0.items }.eraseToAnyPublisher()
    }
}
