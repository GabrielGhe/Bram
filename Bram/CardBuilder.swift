//
//  CardFactory.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-06.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit
import RealmSwift

class CardBuilder {
    fileprivate var userId: String
    fileprivate var cardId: String
    fileprivate var deckId: String
    fileprivate var question: String
    fileprivate var answer: String
    fileprivate var creationDate: Date
    fileprivate var associatedCards: List<CardDue>
    fileprivate var dateToShow: Date
    fileprivate var daysToWait: Int
    
    required init() {
        let tempCard = Card()
        userId = tempCard.userId
        cardId = tempCard.cardId
        deckId = tempCard.deckId
        question = tempCard.question
        answer = tempCard.answer
        associatedCards = tempCard.associatedCardIds
        creationDate = tempCard.creationDate
        dateToShow = tempCard.dateToShow
        daysToWait = tempCard.daysToWait
    }
    
    func set(userId: String) -> CardBuilder {
        self.userId = userId
        return self
    }
    
    func set(cardId: String) -> CardBuilder  {
        self.cardId = cardId
        return self
    }
    
    func set(deckId: String) -> CardBuilder  {
        self.deckId = deckId
        return self
    }
    
    func set(question: String) -> CardBuilder {
        self.question = question
        return self
    }
    
    func set(answer: String) -> CardBuilder {
        self.answer = answer
        return self
    }
    
    func set(creationDate: Date) -> CardBuilder {
        self.creationDate = creationDate
        return self
    }
    
    func set(associatedCards: List<CardDue>) -> CardBuilder {
        self.associatedCards = associatedCards
        return self
    }
    
    func set(dateToShow: Date) -> CardBuilder {
        self.dateToShow = dateToShow.s
        return self
    }
    
    func set(daysToWait: Int) -> CardBuilder {
        self.daysToWait = daysToWait
        return self
    }
    
    func set(otherCard: Card) -> CardBuilder {
        self.userId = otherCard.userId
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
        return Card(userId: userId,
                    cardId: cardId,
                    deckId: deckId,
                    question: question,
                    answer: answer,
                    creationDate: creationDate,
                    associatedCards: associatedCards,
                    dateToShow: dateToShow,
                    daysToWait: daysToWait)
    }
}
