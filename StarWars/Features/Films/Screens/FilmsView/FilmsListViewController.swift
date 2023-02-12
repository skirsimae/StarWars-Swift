//
//  ViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift
import RxCocoa

class FilmsListViewController: UIViewController {
    
    weak var coordinator: FilmsCoordinator?
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: FilmsListViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: FilmsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Films"
        
        configureTableViewCell()
        configureTableView()
        handleTableViewCellSelection()
    }

    
    private func configureTableViewCell() {
        viewModel.films.drive(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        
        viewModel.error.drive(onNext: { error in
            print("Error occurred: \(String(describing: error))")
        }).disposed(by: disposeBag)
        

        viewModel._films.asObservable().bind(to: tableView
            .rx
            .items(cellIdentifier: FilmTableViewCell.identifier, cellType: FilmTableViewCell.self)) {
                (row, element, cell) in
                if let viewModel = self.viewModel.viewModelForFilm(at: row) {
                    cell.configureWith(viewModel)
                }
        }
        .disposed(by: disposeBag)
    }
    
    func handleTableViewCellSelection() {
        tableView.rx
            .modelSelected(Film.self)
            .asDriver()
            .drive(onNext: { [unowned self] film in
                print("selected \(film)")
                self.coordinator?.showFilm(film: film)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(FilmTableViewCell.nib, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func showFilm(film: Film) {
        coordinator?.showFilm(film: film)
    }
}
//
//extension FilmsViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfFilms
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as? FilmTableViewCell else {
//            fatalError("xib does not exist")
//        }
//
//        if let viewModel = viewModel.viewModelForFilm(at: indexPath.row) {
//            cell.configureWith(viewModel)
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedFilm = Film[indexPath.row]
//        delegate?.showFilm(film: selectedFilm)
//
//        print("selected the cell")
//    }
//}

