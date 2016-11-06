//
//  Deck.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-26.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

class Deck {
    private var cardMap: [String:Card]
    private(set) var name: String
    private(set) var deckId: String
    private(set) var cardsPerDay: Int
    private(set) var creationDate: Date
    
    public var cardIds: [String]{
        return cardMap.keys.sorted()
    }
    
    public var cards: [Card] {
        return cardMap.values.sorted()
    }
    
    convenience init(name: String) {
        self.init(deckId: UUID().uuidString, name: name, cards: [], cardsPerDay: 10, creationDate: Date.s)
    }
    
    init(deckId: String, name: String, cards: [Card], cardsPerDay: Int, creationDate: Date) {
        self.deckId = deckId
        self.name = name
        self.cardsPerDay = cardsPerDay
        self.cardMap = [:]
        self.creationDate = creationDate
        addCards(cards)
    }
    
    func addCard(_ card: Card) {
        addCards([card])
    }
    
    func getCard(byId cardId: String) -> Card? {
        return cardMap[cardId]
    }
    
    func deleteCard(cardId: String) {
        if cardMap[cardId] == nil {
            return
        }
        cardMap.removeValue(forKey: cardId)
    }
    
    func deleteCard(card: Card) {
        self.deleteCard(cardId: card.cardId)
    }
    
    func updateCard(_ card: Card) {
        self.cardMap.updateValue(card, forKey: card.cardId)
    }
    
    func addCards(_ cards: [Card]) {
        for card in cards {
            self.cardMap[card.cardId] = card
        }
    }
    
    func getAssociatedCardsDue(mainCardId: String) -> [CardDue] {
        var cardDues: [CardDue] = []
        if let mainCard = cardMap[mainCardId] {
            for cardId in mainCard.associatedCardIds {
                guard let card = cardMap[cardId] else {
                    continue
                }
                cardDues.append(CardDue(card: card, isReminder: true))
            }
        }
        
        return cardDues
    }
    
    func getCardsDueBy(_ date: Date = Date.e) -> [CardDue] {
        var cardDues:[CardDue] = []
        
        for card in cardMap.values {
            if Date.isSmallerThan(card.dateToShow, date) {
                cardDues.append(CardDue(card: card))
            }
        }
        
        return cardDues.sorted()
    }
}
