//
//  CharacterCollectionViewConfigurator.swift
//  StarWars
//
//  Created by Silva Kirsimae on 28/02/2023.
//
import UIKit

class CharacterCollectionViewConfigurator: NSObject {
    private weak var collectionView: UICollectionView?
    private var collectionViewFlowLayout: UICollectionViewFlowLayout
    
    var displayableItems = [Person?]() {
        didSet {
            reload()
        }
    }
    
//    var cellSize: CGSize {
//        didSet {
//            reload()
//        }
//    }
    
    init(collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.collectionViewFlowLayout = collectionViewFlowLayout

        super.init()

        configure(collectionViewFlowLayout: collectionViewFlowLayout)
    }
    
    private func configure(collectionViewFlowLayout: UICollectionViewFlowLayout) {
        collectionViewFlowLayout.sectionInset = .zero
        collectionViewFlowLayout.minimumLineSpacing = CGFloat(8)
        collectionViewFlowLayout.minimumInteritemSpacing = CGFloat(8)
        collectionViewFlowLayout.itemSize = CGSize(width: 200, height: 200)
        collectionViewFlowLayout.scrollDirection = .horizontal
    }
    
    func reload() {
        collectionViewFlowLayout.invalidateLayout()
        collectionView?.reloadData()
    }
}

extension CharacterCollectionViewConfigurator {
    func configure(collectionView: UICollectionView) {
        collectionView.registerCell(withIdentifier: CharacterCollectionViewCell.identifier)
        collectionView.registerCell(withIdentifier: CharacterCollectionViewCell.identifier)
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        
        self.collectionView = collectionView
    }
}

extension CharacterCollectionViewConfigurator: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayableItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell,
            let item = displayableItems[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(with: item)
        return cell
    }
}
