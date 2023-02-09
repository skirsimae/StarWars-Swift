//
//  FilmsTableViewConfigurator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift

class FilmsTableViewConfigurator: NSObject {
    private weak var tableView: UITableView?
    private weak var viewModel: FilmsViewModel?
    
    let onReloadDataSource = PublishSubject<Void>()
    
    var dataSource: DataSource? {
        didSet {
            reload()
        }
    }
    
    init(viewModel: FilmsViewModel) {
        self.viewModel = viewModel
    }
}

extension FilmsTableViewConfigurator {
    typealias DataSource = [Films]
}

extension FilmsTableViewConfigurator: TableViewConfiguratorType {
    func configure(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func reload() {
        tableView?.reloadData()
    }
}

extension FilmsTableViewConfigurator: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        
}

extension FilmsTableViewConfigurator: UITableViewDelegate {
    
}

