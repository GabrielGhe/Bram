//
//  Card.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

open class Card {
    fileprivate var mId: String
    fileprivate var mQuestion: String
    fileprivate var mAnswer: String
    fileprivate var mCreationDate: Date
    fileprivate var mAssociatedCardIds: [String]
    fileprivate var mDateToShow: Date
    
    fileprivate init(id:String, question:String, answer:String,
                 creationDate: Date, associatedCards: [String], dateToShow: Date) {
        self.mId = id
        self.mQuestion = question
        self.mAnswer = answer
        self.mCreationDate = Date()
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
    
    func getCreationDate() -> Date {
        return self.mCreationDate
    }
    
    func getDateToShow() -> Date {
        return self.mDateToShow
    }
    
    func getAssociatedCardIds() -> [String] {
        return self.getAssociatedCardIds()
    }
    
    class Builder {
        fileprivate var mId: String
        fileprivate var mQuestion: String
        fileprivate var mAnswer: String
        fileprivate var mCreationDate: Date
        fileprivate var mAssociatedCards: [String]
        fileprivate var mDateToShow: Date
        
        init() {
            mId = UUID().uuidString
            mQuestion = ""
            mAnswer = ""
            mAssociatedCards = []
            mCreationDate = Date()
            mDateToShow = Date()
        }
        
        func setId(_ id: String) -> Card.Builder  {
            self.mId = id
            return self
        }
        
        func setQuestion(_ question: String) -> Card.Builder {
            self.mQuestion = question
            return self
        }
        
        func setAnswer(_ answer: String) -> Card.Builder {
            self.mAnswer = answer
            return self
        }
        
        func setCreationDate(_ creationDate: Date) -> Card.Builder {
            self.mCreationDate = creationDate
            return self
        }
        
        func setAssociatedCards(_ associatedCards: [String]) -> Card.Builder {
            self.mAssociatedCards = associatedCards
            return self
        }
        
        func setDateToShow(_ dateToShow: Date) -> Card.Builder {
            self.mDateToShow = dateToShow
            return self
        }
        
        func copyCard(_ otherCard: Card) -> Card.Builder {
            self.mId = otherCard.getId()
            self.mQuestion = otherCard.getQuestion()
            self.mAnswer = otherCard.getAnswer()
            self.mAssociatedCards = otherCard.getAssociatedCardIds()
            self.mCreationDate = otherCard.getCreationDate()
            self.mDateToShow = otherCard.getDateToShow()
            return self
        }
        
        func build() -> Card {
            return Card(id: mId, question: mQuestion, answer: mAnswer, creationDate: mCreationDate, associatedCards: mAssociatedCards, dateToShow: mDateToShow)
        }
    }
}

extension Card : Equatable {}
extension Card : Comparable {}

public func ==(left: Card, right: Card) -> Bool {
    return (left.mDateToShow == right.mDateToShow)
}

public func <(left: Card, right: Card) -> Bool {
    return left.mDateToShow.isGreaterThanDate(right.mDateToShow)
}
