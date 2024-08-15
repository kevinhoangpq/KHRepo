//
//  ReposVC.swift
//  KHRepo
//
//  Created by Huy Hoang on 13/8/24.
//

import UIKit
import Combine

class ReposVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var subscriptions: CancelBag = []
    private var data: [GitRepo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let viewModel: ReposVM = .init()
    private let searchByQuerySubject: DataSubject<String> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func bindViewModel() {
        let output = viewModel.transform(
            input: .init(
                searchByQueryPublisher: searchByQuerySubject.debounce(
                    for: .seconds(1), 
                    scheduler: DispatchQueue.main
                ).eraseToAnyPublisher()
            )
        )
        
        output
            .gitReposPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repos in
                self?.data = repos
            }.store(in: &subscriptions)
    }
}

extension ReposVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchByQuerySubject.send(searchText)
    }
}

extension ReposVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].name
        return cell
    }
}
