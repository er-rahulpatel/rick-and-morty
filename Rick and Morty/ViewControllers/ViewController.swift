//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-12.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables and IBOutlets
    var characters: [Character] = []
    @IBOutlet weak var characterListView: UITableView! {
        didSet {
            characterListView.register(UINib(nibName: Constants.Nibs.listTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Identifier.listTableViewCellIdentifier)
        }
    }
    
    // MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = Utils.getLocalizedString(for: "app_title")
        displayCharacters()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Navigation.showDetailsViewControllerIdentifier,
           let detailViewController = segue.destination as? DetailViewController,
           let selectedRow = characterListView.indexPath(for: sender as! ListTableViewCell)?.row {
            detailViewController.character = characters[selectedRow]
        }
    }
    
    // MARK: - Functions
    
    // Fetch and display results
    func displayCharacters(searchText:String? = nil) {
        makeCharacterEndPointCall(searchText: searchText) {
            [unowned self] characterArray, errorMessage in
            guard let results = characterArray else {
                if let message = errorMessage {
                    characters.removeAll()
                    displayErrorMessage(message)
                    refreshScreen()
                }
                return
            }
            // Assign response and display results
            characters = results
            refreshScreen()
        }
    }
    
    // Display error messages
    func displayErrorMessage(_ message:String) {
        Utils.showErrorMessage(message: message)
    }
    
    // Refresh tableview
    func refreshScreen(){
        characterListView.reloadData()
    }
    
    // Fetch characters
    func makeCharacterEndPointCall(forPage page:Int = 1,
                                   searchText:String? = nil,
                                   completionHandler:@escaping (_ characterArray:[Character]?, _ errorMessage:String?) -> Void){
        let inputParameters = getCharacterEndPointInputParameters(forPage: page, searchText: searchText)
        APIWrapper.requestGetUrl(Constants.Urls.characterEndPoint, params: inputParameters ) { (response:Characters) in
            completionHandler(response.results, nil)
        } failure: { (error, responseData) in
            do {
                if let data = responseData,
                   let jsonString = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    let errorMessage = jsonString["error"]
                    completionHandler(nil, errorMessage)
                }
            }catch {
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    // Prepare input parameters for character endpoint
    func getCharacterEndPointInputParameters(forPage page:Int,
                                             searchText:String? = nil) -> [String:Any] {
        var inputParameters : [String:Any] = ["page": page]
        if let filterText = searchText {
            inputParameters["name"] = filterText
        }
        return inputParameters
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.listTableViewCellIdentifier, for: indexPath) as! ListTableViewCell
        cell.configureCellForCharacter(character: characters[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Navigation.showDetailsViewControllerIdentifier, sender: tableView.cellForRow(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        displayCharacters(searchText: searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
