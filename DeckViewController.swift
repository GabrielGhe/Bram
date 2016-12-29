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
    private var storage: Storage?
    private var data: [Deck] = []
    private let ADD_BUTTON_SIZE = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
        hideSearch()
        initializeView()
        setDelegates()
        addDeckButton()
    }
    
    fileprivate func loadContent() {
        self.storage = StubStorage()
        if let decks = self.storage?.getDecks() {
            data = decks
        }
    }
    
    fileprivate func initializeView() {
        self.search.searchBarStyle = UISearchBarStyle.minimal;
        self.search.barTintColor = UIColor.white
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func addDeckButton() {
        let addButton = UIButton()
        addButton.layer.cornerRadius = CGFloat(ADD_BUTTON_SIZE) * 0.5
        view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-30)
            make.width.height.equalTo(ADD_BUTTON_SIZE)
        }
        addButton.backgroundColor = UIColor(red:0.11, green:0.62, blue:0.45, alpha:1.0)
        addButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        addButton.setTitle(String.fontAwesomeIcon(code: "fa-plus"), for: UIControlState.normal)
        
        addButton.layer.shadowColor = UIColor.gray.cgColor;
        addButton.layer.shadowOffset = CGSize(width: 0.5, height:2.0);
        addButton.layer.shadowOpacity = 1.0;
        addButton.layer.shadowRadius = 0.0;
    }
    
    fileprivate func hideSearch() {
        self.tableView.setContentOffset(CGPoint(x: 0, y: search.bounds.height), animated: false)
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
        let deck = data[indexPath.row]
        cell.createView(withDeck: deck)
        
        return cell
    }
}
