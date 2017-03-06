//
//  CardTableViewCell.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-03-05.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit
import SnapKit

class CardTableViewCell: UITableViewCell {
    weak var card: Card?
    weak var tableView: UITableView?
    private let SIDE_DISTANCE = 5
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        guard let card = self.card, let tableView = self.tableView else {
//            return
//        }
//        
//        initialize(card: card, tableView: tableView)
//    }
//    
//    func initialize(card: Card, tableView: UITableView) {
//        initializeCell(tableView: tableView)
//        initializeCard(card: card, tableView: tableView)
//        
//    }
    
    var myLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        myLabel.backgroundColor = UIColor.yellow
        self.contentView.addSubview(myLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
        myLabel.text = "blah 1"
    }
    
//    func initializeCard(card: Card, tableView: UITableView) {
//        let questionLabel = UILabel()
//        questionLabel.text = card.question
//
//        let questionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//        questionLabel.textAlignment = NSTextAlignment.center
//        questionLabel.text = card.question
//        
//        let answerLabel = UILabel()
//        answerLabel.text = card.answer
//        
//        self.contentView.addSubview(questionLabel)
//        self.contentView.addSubview(answerLabel)
//        
//        questionLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(self.contentView).offset(SIDE_DISTANCE)
//            make.left.equalTo(self.contentView).offset(SIDE_DISTANCE)
//        }
//        
//        answerLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(questionLabel.snp.bottom).offset(SIDE_DISTANCE)
//            make.left.equalTo(self.contentView).offset(SIDE_DISTANCE)
//        }
//    }
//    
//    func initializeCell(tableView: UITableView) {
//        self.contentView.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(tableView).offset(SIDE_DISTANCE)
//            make.right.equalTo(tableView).offset(-SIDE_DISTANCE)
//        }
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}
