//
//  CharactersListViewController.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import RxSwift
import RxCocoa
import RxDataSources

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var charactersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CharactersViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        configureTableView()
        bindDataSource()
        handleSegmentedControlSelection()
        handleError()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(CharacterTableViewCell.nib, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    private func bindDataSource() {
        let dataSource = RxTableViewSectionedAnimatedDataSource<CharacterModel> (
            configureCell: { dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else { fatalError() }
                cell.configureWith(item)
                return cell
            })
        
        viewModel.characters
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func handleSegmentedControlSelection() {
        viewModel.selectedCharacterType.asObservable().subscribe(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        charactersSegmentedControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .subscribe{ [self] _ in
                switch charactersSegmentedControl.selectedSegmentIndex {
                case 0: viewModel._selectedCharacterType.accept(.people)
                case 1:  viewModel._selectedCharacterType.accept(.species)
                default: break
                }
            }
            .disposed(by: disposeBag)
        
        viewModel._selectedCharacterType.asObservable().subscribe { [unowned self] character in
            self.viewModel.fetchCharacters()
        }.disposed(by: disposeBag)
    }
    
    private func handleError() {
        //TODO: show error
        viewModel.error.drive(onNext: { error in
            print("Error occurred: \(String(describing: error))")
        }).disposed(by: disposeBag)
    }
}
