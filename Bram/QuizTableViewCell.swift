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
    
    func initializeCard(card: Card) {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(QuizTableViewCell.tapped))
        singleTap.numberOfTapsRequired = 1
        
        self.contentView.addGestureRecognizer(singleTap)
        self.contentView.addSubview(questionCard)
        
        let height = self.contentView.frame.height
        let width = self.contentView.frame.width
        
        styleQuestion(card: card, height: height, width: width)
        styleAnswer(card: card, height: height, width: width)
    }
    
    func styleQuestion(card: Card, height: CGFloat, width: CGFloat) {
        questionCard.frame = CGRect(x: 0, y: 0, width: width, height: height)
        questionLabel.backgroundColor = .lightGray
        
        questionLabel.text = card.question
        questionLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func styleAnswer(card: Card, height: CGFloat, width: CGFloat) {
        answerCard.frame = CGRect(x: 0, y: 0, width: width, height: height)
        answerLabel.backgroundColor = .lightGray
        
        answerLabel.text = card.answer
        answerLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
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
