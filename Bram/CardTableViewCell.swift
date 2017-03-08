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
    weak var card = Card()
    private let SIDE_DISTANCE = 15
    private var questionLabel = UILabel()
    private var answerLabel = UILabel()
    
    func initialize() {
        self.contentView.addSubview(questionLabel)
        self.contentView.addSubview(answerLabel)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initializeCard(card: card!)
    }
    
    func initializeCard(card: Card) {
        questionLabel.text = card.question
        answerLabel.text = card.answer
        
        questionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView.snp.top).offset(SIDE_DISTANCE)
            make.left.equalTo(self.contentView.snp.left).offset(SIDE_DISTANCE)
            make.right.equalTo(self.contentView.snp.right).offset(SIDE_DISTANCE)
        }
        answerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(questionLabel.snp.bottom).offset(SIDE_DISTANCE)
            make.left.equalTo(self.contentView.snp.left).offset(SIDE_DISTANCE)
            make.right.equalTo(self.contentView.snp.right).offset(SIDE_DISTANCE)
        }
    }
}
