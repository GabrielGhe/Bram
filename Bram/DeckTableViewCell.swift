//
//  DeckTableViewCell.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-10.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import SnapKit

class DeckTableViewCell: UITableViewCell {
    @IBOutlet weak var myView: UIView!
    
    func createView(withDeck deck: Deck) {
        let cardsText = createCardsText(
            cardsDue: deck.getCardsDueBy().count,
            cardsTotal: deck.cards.count)
        
        let iconLabel = createIconLabel(ofSize: 30)
        let titleLabel = createLabel(withTitle: deck.name)
        let cardsLabel = createLabel(withTitle: cardsText, ofSize: 14)
        
        self.accessoryType = .disclosureIndicator
        self.myView.addSubview(iconLabel)
        self.myView.addSubview(titleLabel)
        self.myView.addSubview(cardsLabel)
        
        arrangeViews(view: iconLabel, top: 5, left: 15, bottom: 5, right: 10)
        arrangeViews(view: titleLabel, top: -15, left: 55, bottom: 5, right: 10)
        arrangeViews(view: cardsLabel, top: 30, left: 55, bottom: 10, right: 10)
    }
    
    func arrangeViews(view: UILabel, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        view.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(myView).inset(UIEdgeInsetsMake(top, left, bottom, right))
        }
    }
    
    func createCardsText(cardsDue: Int, cardsTotal: Int) -> String {
        return "\(cardsDue) / \(cardsTotal) due"
    }
    
    func createLabel(withTitle title:String, ofSize size: Int = 18) -> UILabel{
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: CGFloat(size))
        label.text = title
        return label
    }
    
    func createIconLabel(ofSize size: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: size)
        label.text = String.fontAwesomeIcon(code: "fa-list")
        //label.textColor = UIColor.blue
        return label
    }
}
