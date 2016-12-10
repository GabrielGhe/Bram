//
//  DeckViewController.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-10.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import FontAwesome_swift

class DeckViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let data = ["deck 1", "The second one", "Deck thirty minus twenty nine", "four", "The fifth"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        hideSearch()
    }
    
    fileprivate func hideSearch() {
        tableView.setContentOffset(CGPoint(x: 0, y: search.bounds.height), animated: false)
    }
    
    // How many sections (only 1 in our case)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    // How many rows to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // What to display for a particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeckCell") as! DeckTableViewCell
        let title = data[indexPath.row]
        cell.createView(withTitle: title)
        
        return cell
    }
}
