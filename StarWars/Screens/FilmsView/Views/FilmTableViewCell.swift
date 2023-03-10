//
//  FilmTableViewCell.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filmLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        filmLabel.text = nil
    }
    
    func configureWith(_ viewModel: FilmTableViewCellViewModel) {
        filmLabel.text = viewModel.title
    }
    
}
