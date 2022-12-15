//
//  DetailViewController.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-12.
//

import UIKit


struct DetailItem {
    let itemTitle : String
    let itemDescription : String
}

class DetailViewController: UIViewController {
    // MARK: - Variables and IBOutlets
    var character: Character? {
        didSet {
            self.navigationItem.title = character?.name
        }
    }
    @IBOutlet weak var characterDetailTableView: UITableView! {
        didSet {
            characterDetailTableView.register(UINib(nibName: Constants.Nibs.listTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifier.detailTableViewCellIdentifier)
            characterDetailTableView.register(UINib(nibName: Constants.Nibs.detailTableHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Identifier.detailTableHeaderViewIdentifier)
        }
    }
    // To display character detail attributes
    var detailItems: [DetailItem] = [] {
        didSet {
            characterDetailTableView.reloadData()
        }
    }
    
    // MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Assign attributes from character object
        detailItems = mapDetailsFrom(character: character) ?? []
    }
    
    // MARK: - Functions
    func mapDetailsFrom(character:Character?) -> [DetailItem]? {
        guard let characterObject = character else { return nil }
        var outputResult: [DetailItem] = []
        outputResult.append(DetailItem(itemTitle: Utils.getLocalizedString(for: "name"), itemDescription: characterObject.name))
        outputResult.append(DetailItem(itemTitle: Utils.getLocalizedString(for: "status"), itemDescription: characterObject.status))
        outputResult.append(DetailItem(itemTitle: Utils.getLocalizedString(for: "species"), itemDescription: characterObject.species))
        outputResult.append(DetailItem(itemTitle: Utils.getLocalizedString(for: "gender"), itemDescription: characterObject.gender))
        outputResult.append(DetailItem(itemTitle: Utils.getLocalizedString(for: "current_location"), itemDescription: characterObject.locationName))
        return outputResult
    }
    
    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.detailTableViewCellIdentifier, for: indexPath) as! ListTableViewCell
        cell.configureCellForCharacterDetail(detailItem: detailItems[indexPath.row])
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let characterObject = character else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Identifier.detailTableHeaderViewIdentifier) as! DetailTableHeaderView
        headerView.configureHeaderViewForCharacterImage(imageUrl: URL(string: characterObject.image))
        return headerView
    }
}
