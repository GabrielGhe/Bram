//
//  Card.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

public class Card: NSObject {
    private var mId: String
    private var mQuestion: String
    private var mAnswer: String
    private var mCreateDate: NSDate
    private var mAssociatedCards: [String]
    
    private init(id:String, question:String, answer:String,
                 creationDate: NSDate, associatedCards: [String]) {
        self.mId = id
        self.mQuestion = question
        self.mAnswer = answer
        self.mCreateDate = NSDate()
        self.mAssociatedCards = associatedCards
    }
    
    class Builder: NSObject {
        private var mId: String
        private var mQuestion: String
        private var mAnswer: String
        private var mCreateDate: NSDate
        private var mAssociatedCards: [String]
        
        override init() {
            mId = "" //generate new id
            mQuestion = ""
            mAnswer = ""
            mAssociatedCards = []
            mCreateDate = NSDate()
        }
        
        func setId(id: String) {
            self.mId = id
        }
        
        func setQuestion(question: String) {
            self.mQuestion = question
        }
        
        func setAnswer(answer: String) {
            self.mAnswer = answer
        }
        
        func setCreateDate(createDate: NSDate) {
            self.mCreateDate = createDate
        }
        
        func setAssociatedCards(associatedCards: [String]) {
            self.mAssociatedCards = associatedCards
        }
        
        func build() -> Card {
            return Card(id: mId, question: mQuestion, answer: mAnswer, creationDate: mCreateDate, associatedCards: mAssociatedCards)
        }
    }
}