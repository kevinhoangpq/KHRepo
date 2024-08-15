//
//  ReposExpected.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Combine
import Foundation

protocol ReposExpected {
    func searchRepos(
        withQuery query: String
    ) -> AnyPublisher<[GitRepo], Error>
}
