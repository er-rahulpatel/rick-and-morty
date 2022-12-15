//
//  DetailTableHeaderView.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-14.
//

import UIKit
import Kingfisher

class DetailTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var thumbnail: UIImageView!
    
    // Display header view
    func configureHeaderViewForCharacterImage(imageUrl: URL?){
        thumbnail.kf.setImage(with: imageUrl)
    }

}
