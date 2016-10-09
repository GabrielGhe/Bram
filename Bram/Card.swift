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
    fileprivate var mDaysToWait: Int
    
    fileprivate init(id:String, question:String, answer:String,
                     creationDate: Date, associatedCards: [String], dateToShow: Date, daysToWait: Int) {
        self.mId = id
        self.mQuestion = question
        self.mAnswer = answer
        self.mCreationDate = Date()
        self.mDateToShow = dateToShow
        self.mAssociatedCardIds = associatedCards
        self.mDaysToWait = daysToWait
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
        return self.mAssociatedCardIds
    }
    
    func getDaysToWait() -> Int {
        return self.mDaysToWait
    }
    
    class Builder {
        fileprivate var mId: String
        fileprivate var mQuestion: String
        fileprivate var mAnswer: String
        fileprivate var mCreationDate: Date
        fileprivate var mAssociatedCards: [String]
        fileprivate var mDateToShow: Date
        fileprivate var mDaysToWait: Int
        
        init() {
            mId = UUID().uuidString
            mQuestion = ""
            mAnswer = ""
            mAssociatedCards = []
            mCreationDate = Date()
            mDateToShow = Date()
            mDaysToWait = 1
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
        
        func setDaysToWait(_ daysToWait: Int) -> Card.Builder {
            self.mDaysToWait = daysToWait
            return self
        }
        
        func setCard(_ otherCard: Card) -> Card.Builder {
            self.mId = otherCard.getId()
            self.mQuestion = otherCard.getQuestion()
            self.mAnswer = otherCard.getAnswer()
            self.mAssociatedCards = otherCard.getAssociatedCardIds()
            self.mCreationDate = otherCard.getCreationDate()
            self.mDateToShow = otherCard.getDateToShow()
            self.mDaysToWait = otherCard.getDaysToWait()
            return self
        }
        
        func build() -> Card {
            return Card(id: mId, question: mQuestion, answer: mAnswer, creationDate: mCreationDate, associatedCards: mAssociatedCards, dateToShow: mDateToShow, daysToWait: mDaysToWait)
        }
    }
}

extension Card : Equatable {}
extension Card : Comparable {}

public func ==(left: Card, right: Card) -> Bool {
    return (left.mId == right.mId)
}

public func <(left: Card, right: Card) -> Bool {
    return left.mDateToShow.isGreaterThanDate(right.mDateToShow)
}
