//
//  FilmDetailsHeaderTableViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 23/02/2023.
//

import UIKit

class FilmDetailsHeaderTableViewCell: FilmDetailsTableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var episodeIdLabel: UILabel!
    @IBOutlet weak var openingCrawlLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(with viewModel: FilmDetailsItemViewModel) {
        guard let model = viewModel as? FilmDetailsHeaderViewModel else { return }
    
        episodeIdLabel.text = String(model.film.episodeID)
        openingCrawlLabel.text = model.film.openingCrawl
        directorLabel.text = model.film.director
        producerLabel.text = model.film.producer
        releaseDate.text = model.film.releaseDate
    }

}
