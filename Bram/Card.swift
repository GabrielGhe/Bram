//
//  Card.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

public class Card {
    private var mId: String
    private var mQuestion: String
    private var mAnswer: String
    private var mCreateDate: NSDate
    private var mAssociatedCards: [String]
    private var mDateToShow: NSDate
    
    private init(id:String, question:String, answer:String,
                 creationDate: NSDate, associatedCards: [String], dateToShow: NSDate) {
        self.mId = id
        self.mQuestion = question
        self.mAnswer = answer
        self.mCreateDate = NSDate()
        self.mDateToShow = dateToShow
        self.mAssociatedCards = associatedCards
    }
    
    class Builder {
        private var mId: String
        private var mQuestion: String
        private var mAnswer: String
        private var mCreateDate: NSDate
        private var mAssociatedCards: [String]
        private var mDateToShow: NSDate
        
        init() {
            mId = "" //generate new id
            mQuestion = ""
            mAnswer = ""
            mAssociatedCards = []
            mCreateDate = NSDate()
            mDateToShow = NSDate()
        }
        
        func setId(id: String) -> Card.Builder  {
            self.mId = id
            return self
        }
        
        func setQuestion(question: String) -> Card.Builder {
            self.mQuestion = question
            return self
        }
        
        func setAnswer(answer: String) -> Card.Builder {
            self.mAnswer = answer
            return self
        }
        
        func setCreateDate(createDate: NSDate) -> Card.Builder {
            self.mCreateDate = createDate
            return self
        }
        
        func setAssociatedCards(associatedCards: [String]) -> Card.Builder {
            self.mAssociatedCards = associatedCards
            return self
        }
        
        func setDateToShow(dateToShow: NSDate) -> Card.Builder {
            self.mDateToShow = dateToShow
            return self
        }
        
        func build() -> Card {
            return Card(id: mId, question: mQuestion, answer: mAnswer, creationDate: mCreateDate, associatedCards: mAssociatedCards, dateToShow: mDateToShow)
        }
    }
}

extension Card : Equatable {}
extension Card : Comparable {}

public func ==(left: Card, right: Card) -> Bool {
    return left.mDateToShow.isEqualToDate(right.mDateToShow)
}

public func <(left: Card, right: Card) -> Bool {
    return left.mDateToShow.isGreaterThanDate(right.mDateToShow)
}
