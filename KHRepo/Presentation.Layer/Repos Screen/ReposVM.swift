//
//  ReposVM.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import Combine
import Foundation

class ReposVM {
    private(set) var subscriptions: CancelBag = []
    
    private let repo: Repos
    private let gitReposSubject: DataSubject<[GitRepo]> = .init()
    
    init(repo: Repos = Repos()) {
        self.repo = repo
    }
}

extension ReposVM: ViewModelExpected {
    struct Input {
        let searchByQueryPublisher: DataPublisher<String>
    }
    
    struct Output {
        let gitReposPublisher: DataPublisher<[GitRepo]>
    }
    
    func transform(input: Input) -> Output {
        return Output(
            gitReposPublisher: input
                .searchByQueryPublisher
                .map { self.searchGitReposByQuery($0) }
                .switchToLatest()
                .eraseToAnyPublisher()
        )
    }
}

private extension ReposVM {
    func searchGitReposByQuery(_ query: String) -> AnyPublisher<[GitRepo], Never> {
        repo
            .searchRepos(withQuery: query)
            .catch { error in
                print("Search git repos error: \(error)")
                return Just([GitRepo]()).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
