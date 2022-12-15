//
//  ListTableViewCell.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-14.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Display character list items
    func configureCellForCharacter(character:Character) {
        thumbnail.kf.setImage(with:URL(string: character.image))
        itemTitle.text = character.name
        itemDescription.text = "\(Utils.getLocalizedString(for: "appeared_in")) \(character.episode.count) \(Utils.getLocalizedString(for: "episodes"))"
    }
    
    // Display character detail attributes
    func configureCellForCharacterDetail(detailItem: DetailItem) {
        thumbnail?.removeFromSuperview()
        itemTitle.text = detailItem.itemTitle
        itemDescription.text = detailItem.itemDescription
    }
    
}


