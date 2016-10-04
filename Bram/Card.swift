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
    private var mCreationDate: NSDate
    private var mAssociatedCardIds: [String]
    private var mDateToShow: NSDate
    
    private init(id:String, question:String, answer:String,
                 creationDate: NSDate, associatedCards: [String], dateToShow: NSDate) {
        self.mId = id
        self.mQuestion = question
        self.mAnswer = answer
        self.mCreationDate = NSDate()
        self.mDateToShow = dateToShow
        self.mAssociatedCardIds = associatedCards
    }
    
    func getId() -> String {
        return self.mId
    }
    
    func getQuestion() -> String {
        return self.mQuestion
    }
    
    func getAnswer() -> String {
        return self.mAnswer
    }
    
    func getCreationDate() -> NSDate {
        return self.mCreationDate
    }
    
    func getDateToShow() -> NSDate {
        return self.mDateToShow
    }
    
    func getAssociatedCardIds() -> [String] {
        return self.getAssociatedCardIds()
    }
    
    class Builder {
        private var mId: String
        private var mQuestion: String
        private var mAnswer: String
        private var mCreationDate: NSDate
        private var mAssociatedCards: [String]
        private var mDateToShow: NSDate
        
        init() {
            mId = UUID().uuidString
            mQuestion = ""
            mAnswer = ""
            mAssociatedCards = []
            mCreationDate = NSDate()
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
        
        func setCreationDate(creationDate: NSDate) -> Card.Builder {
            self.mCreationDate = creationDate
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
        
        func copyCard(otherCard: Card) -> Card.Builder {
            self.mId = otherCard.getId()
            self.mQuestion = otherCard.getQuestion()
            self.mAnswer = otherCard.getAnswer()
            self.mAssociatedCards = otherCard.getAssociatedCardIds()
            self.mCreationDate = otherCard.getCreationDate()
            self.mDateToShow = otherCard.getDateToShow()
        }
        
        func build() -> Card {
            return Card(id: mId, question: mQuestion, answer: mAnswer, creationDate: mCreationDate, associatedCards: mAssociatedCards, dateToShow: mDateToShow)
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
