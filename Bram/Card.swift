//
//  Card.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-22.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

open class Card {
    private(set) var cardId: String
    private(set) var deckId: String
    private(set) var question: String
    private(set) var answer: String
    private(set) var creationDate: Date
    private(set) var associatedCardIds: [String]
    private(set) var dateToShow: Date
    private(set) var daysToWait: Int
    
    fileprivate init(cardId:String, deckId:String, question:String, answer:String,
                     creationDate: Date, associatedCards: [String], dateToShow: Date, daysToWait: Int) {
        self.cardId = cardId
        self.deckId = deckId
        self.question = question
        self.answer = answer
        self.creationDate = creationDate
        self.dateToShow = dateToShow
        self.associatedCardIds = associatedCards
        self.daysToWait = daysToWait
    }
    
    class Builder {
        fileprivate var cardId: String
        fileprivate var deckId: String
        fileprivate var question: String
        fileprivate var answer: String
        fileprivate var creationDate: Date
        fileprivate var associatedCards: [String]
        fileprivate var dateToShow: Date
        fileprivate var daysToWait: Int
        
        init() {
            cardId = UUID().uuidString
            deckId = UUID().uuidString
            question = ""
            answer = ""
            associatedCards = []
            creationDate = Date.s
            dateToShow = Date.s
            daysToWait = 1
        }
        
        func setCardId(_ id: String) -> Card.Builder  {
            self.cardId = id
            return self
        }
        
        func setDeckId(_ id: String) -> Card.Builder  {
            self.deckId = id
            return self
        }
        
        func setQuestion(_ question: String) -> Card.Builder {
            self.question = question
            return self
        }
        
        func setAnswer(_ answer: String) -> Card.Builder {
            self.answer = answer
            return self
        }
        
        func setCreationDate(_ creationDate: Date) -> Card.Builder {
            self.creationDate = creationDate
            return self
        }
        
        func setAssociatedCards(_ associatedCards: [String]) -> Card.Builder {
            self.associatedCards = associatedCards
            return self
        }
        
        func setDateToShow(_ dateToShow: Date) -> Card.Builder {
            self.dateToShow = dateToShow.s
            return self
        }
        
        func setDaysToWait(_ daysToWait: Int) -> Card.Builder {
            self.daysToWait = daysToWait
            return self
        }
        
        func setCard(_ otherCard: Card) -> Card.Builder {
            self.cardId = otherCard.cardId
            self.deckId = otherCard.deckId
            self.question = otherCard.question
            self.answer = otherCard.answer
            self.associatedCards = otherCard.associatedCardIds
            self.creationDate = otherCard.creationDate
            self.dateToShow = otherCard.dateToShow
            self.daysToWait = otherCard.daysToWait
            return self
        }
        
        func build() -> Card {
            return Card(cardId: cardId,
                        deckId: deckId,
                        question: question,
                        answer: answer,
                        creationDate: creationDate,
                        associatedCards: associatedCards,
                        dateToShow: dateToShow,
                        daysToWait: daysToWait)
        }
    }
}

extension Card : Equatable {}
extension Card : Comparable {}

public func ==(left: Card, right: Card) -> Bool {
    return (left.cardId == right.cardId)
}

public func <(left: Card, right: Card) -> Bool {
    return left.dateToShow.isGreaterThanDate(right.dateToShow)
}
