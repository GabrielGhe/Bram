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
        cardId = tempCard.cardId
        deckId = tempCard.deckId
        question = tempCard.question
        answer = tempCard.answer
        associatedCards = tempCard.associatedCardIds
        creationDate = tempCard.creationDate
        dateToShow = tempCard.dateToShow
        daysToWait = tempCard.daysToWait
    }
    
    func setCardId(_ id: String) -> CardBuilder  {
        self.cardId = id
        return self
    }
    
    func setDeckId(_ id: String) -> CardBuilder  {
        self.deckId = id
        return self
    }
    
    func setQuestion(_ question: String) -> CardBuilder {
        self.question = question
        return self
    }
    
    func setAnswer(_ answer: String) -> CardBuilder {
        self.answer = answer
        return self
    }
    
    func setCreationDate(_ creationDate: Date) -> CardBuilder {
        self.creationDate = creationDate
        return self
    }
    
    func setAssociatedCards(_ associatedCards: List<CardDue>) -> CardBuilder {
        self.associatedCards = associatedCards
        return self
    }
    
    func setDateToShow(_ dateToShow: Date) -> CardBuilder {
        self.dateToShow = dateToShow.s
        return self
    }
    
    func setDaysToWait(_ daysToWait: Int) -> CardBuilder {
        self.daysToWait = daysToWait
        return self
    }
    
    func setCard(_ otherCard: Card) -> CardBuilder {
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
