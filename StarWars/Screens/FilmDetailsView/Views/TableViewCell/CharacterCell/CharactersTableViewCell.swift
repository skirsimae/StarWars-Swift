//
//  CharactersTableViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

import UIKit

class CharactersTableViewCell: FilmDetailsTableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    let collectionViewConfigurator = CharacterCollectionViewConfigurator()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionViewConfigurator.configure(collectionView: collectionView)
    }

    override func configure(with viewModel: FilmDetailsItemViewModel) {
        guard let viewModel = viewModel as? CharactersTableViewCellViewModel else { return }
            
        let items = viewModel.people
        collectionViewConfigurator.displayableItems = items
    }
    
}


extension UICollectionView {
    func registerCell(withIdentifier identifier: String, fromBundle bundle: Bundle = Bundle.main) {
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
