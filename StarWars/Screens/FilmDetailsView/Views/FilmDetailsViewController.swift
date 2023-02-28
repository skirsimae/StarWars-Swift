//
//  FilmDetailsTableViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 11/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class FilmDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: FilmDetailsViewModel
    
    var filmDetailsItemViewModels = [FilmDetailsItemViewModel?]() {
        didSet {
            reload()
        }
    }
    
    func reload() {
        tableView?.reloadData()
    }
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: FilmDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        applyViewModel()
        configureTableView()
    }
    
    private func applyViewModel() {
        bind(to: viewModel)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        
        tableView.registerCell(withIdentifier: FilmDetailsHeaderTableViewCell.identifier)
        tableView.registerCell(withIdentifier: CharactersTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}

extension FilmDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmDetailsItemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let filmDetailsItemViewModel = filmDetailsItemViewModels[indexPath.row] else {
            return UITableViewCell()
        }

        let identifier = filmDetailsItemViewModel.type.cellType

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FilmDetailsTableViewCell else {
            return UITableViewCell()
        }
        
//        if let characterCell = cell as? CharactersTableViewCell {
//            characterCell.configure(items: viewModel.displayableItems)
//        }

        cell.configure(with: filmDetailsItemViewModel)

        return cell
    }
}

extension FilmDetailsViewController: ViewModelBindable {
    typealias ViewModelType = FilmDetailsViewModel
    
    func bind(viewModel input: FilmDetailsViewModel.Input) {
        
        rx.viewWillAppear
            .bind(to: viewModel.input.onViewDidLoad)
            .disposed(by: disposeBag)
    }
    
    func bind(viewModel output: FilmDetailsViewModel.Output) {
        output.filmDetailsItemViewModels
            .subscribe(onNext: { [weak self] filmDetailsItemViewModels in
                self?.filmDetailsItemViewModels = filmDetailsItemViewModels
            })
            .disposed(by: disposeBag)

    }
}


extension UITableView {
    func registerCell(withIdentifier identifier: String, fromBundle bundle: Bundle = Bundle.main) {
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
}
