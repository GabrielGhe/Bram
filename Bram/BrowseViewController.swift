//
//  BrowseViewController.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-03-05.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var cardsTableView: UITableView?
    private var cards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        getCards()
    }
    
    // MARK: - TableView
    
    func getCards() {
        let tempCard = CardBuilder()
            .set(cardId: "1 - test")
            .set(question: "1 - thing")
            .set(answer: "1 - blah")
            .build()
        let fetchedCards = BramStorage.sharedInstance.getCards()
        for copyCard in fetchedCards {
            print(copyCard.userId)
            print(copyCard.cardId)
            print(copyCard.question)
            print(copyCard.answer)
        }
        self.cards.append(tempCard)
        self.cards.append(contentsOf: fetchedCards)
    }
    
    func createTableView() {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CardTableViewCell
        
        cell.tableView = tableView
        cell.card = cards[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
