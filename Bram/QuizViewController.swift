//
//  QuizViewController.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-03-09.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var cardsTableView: UITableView?
    private var cards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        getCards()
    }
    
    // MARK: - TableView
    
    func getCards() {
        let fetchedCards = BramStorage.sharedInstance.getCards()
        for copyCard in fetchedCards {
            print(copyCard.userId)
            print(copyCard.cardId)
            print(copyCard.question)
            print(copyCard.answer)
        }
        self.cards.append(contentsOf: fetchedCards)
    }
    
    func createTableView() {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        tableView.register(QuizTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        cardsTableView = tableView
        self.view.addSubview(cardsTableView!)
        cardsTableView?.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.view)
            make.center.equalTo(self.view)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuizTableViewCell
        cell.card = cards[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let cardToDelete = cards.remove(at: indexPath.row)
            BramStorage.sharedInstance.delete(card: cardToDelete)
            self.cardsTableView?.reloadData()
        }
    }
}
