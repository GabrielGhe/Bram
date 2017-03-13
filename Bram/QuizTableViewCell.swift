//
//  QuizTableViewCell.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-03-12.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit
import SnapKit

class QuizTableViewCell: UITableViewCell {
    weak var card = Card()
    private let SIDE_DISTANCE = 15
    private var questionCard = UIView()
    private var answerCard = UIView()
    private var questionLabel = UILabel()
    private var answerLabel = UILabel()
    private var isAnswerShowing = false
    
    func initialize() {
        questionCard.addSubview(questionLabel)
        answerCard.addSubview(answerLabel)
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
    
    func styleQuestion(card: Card) {
        questionCard.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView.snp.center)
            make.size.equalTo(self.contentView.snp.size)
        }
        questionCard.backgroundColor = .blue
        
        questionLabel.text = card.question
        questionLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView.snp.center)
            make.size.equalTo(self.contentView.snp.size)
        }
    }
    
    func styleAnswer(card: Card) {
        answerCard.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView.snp.center)
            make.size.equalTo(self.contentView.snp.size)
        }
        questionCard.backgroundColor = .red
        
        answerLabel.text = card.answer
        answerLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView.snp.center)
            make.size.equalTo(self.contentView.snp.size)
        }
    }
    
    func initializeCard(card: Card) {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(QuizTableViewCell.tapped))
        singleTap.numberOfTapsRequired = 1
        
        self.contentView.addGestureRecognizer(singleTap)
        self.contentView.addSubview(questionCard)
        
        styleQuestion(card: card)
        styleAnswer(card: card)
    }
    
    func tapped() {
        var showingSide = questionCard
        var hiddenSide = answerCard
        if isAnswerShowing {
            (showingSide, hiddenSide) = (answerCard, questionCard)
        }
        
        UIView.transition(from: showingSide,
                          to: hiddenSide,
                          duration: 0.7,
                          options: UIViewAnimationOptions.transitionFlipFromBottom,
                          completion: nil)
        
        isAnswerShowing = !isAnswerShowing
    }
}
