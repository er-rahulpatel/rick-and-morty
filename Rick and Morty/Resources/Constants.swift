//
//  Constants.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-12.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let baseUrl = "https://rickandmortyapi.com/api/"
        static let characterEndPoint = baseUrl + "character"
    }
    
    struct Nibs {
        static let listTableViewCell = "ListTableViewCell"
        static let detailTableHeaderView = "DetailTableHeaderView"
    }
    
    struct Identifier {
        static let listTableViewCellIdentifier = "listTableViewCellIdentifier"
        static let detailTableViewCellIdentifier = "detailTableViewCellIdentifier"
        static let detailTableHeaderViewIdentifier = "detailTableHeaderViewIdentifier"
    }
    
    struct Navigation {
        static let showDetailsViewControllerIdentifier = "showDetailsViewController"
    }
}
