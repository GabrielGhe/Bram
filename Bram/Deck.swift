//
//  Deck.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-26.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

class Deck {
    fileprivate var cardMap: [String:Card]
    private(set) var name: String
    private(set) var deckId: String
    private(set) var cardsPerDay: Int
    
    public var cardIds: [String]{
        return cardMap.keys.sorted()
    }
    
    public var cards: [Card] {
        return cardMap.values.sorted()
    }
    
    convenience init(name: String) {
        self.init(deckId: UUID().uuidString, name: name, cards: [], cardsPerDay: 10)
    }
    
    init(deckId: String, name: String, cards: [Card], cardsPerDay: Int) {
        self.deckId = deckId
        self.name = name
        self.cardsPerDay = cardsPerDay
        self.cardMap = [:]
        addCards(cards)
    }
    
    func addCard(_ card: Card) {
        addCards([card])
    }
    
    func deleteCard(_ card: Card) {
        var cardRemoved = cardMap.removeValue(forKey: card.cardId)
    }
    
    func updateCard(_ card: Card) {
        self.cardMap.updateValue(card, forKey: card.cardId)
    }
    
    func addCards(_ cards: [Card]) {
        for card in cards {
            self.cardMap[card.cardId] = card
        }
    }
}
