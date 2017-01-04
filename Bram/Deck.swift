//
//  Deck.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-09-26.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit
import RealmSwift

class Deck : Object {
    private var cardMap: [String:Card]
    private(set) dynamic var name: String
    private(set) dynamic var deckId: String
    private(set) dynamic var cardsPerDay: Int
    private(set) dynamic var creationDate: Date
    
    public var cardIds: [String] {
        return cardMap.keys.sorted()
    }
    
    public var cards: [Card] {
        return cardMap.values.sorted()
    }
    
    convenience init(name: String) {
        self.init(deckId: UUID().uuidString, name: name, cards: [], cardsPerDay: 10, creationDate: Date.s)
    }
    
    required init(deckId: String, name: String, cards: [Card], cardsPerDay: Int, creationDate: Date) {
        self.deckId = deckId
        self.name = name
        self.cardsPerDay = cardsPerDay
        self.cardMap = [:]
        self.creationDate = creationDate
        add(cards: cards)
    }
    
    func add(card: Card) {
        add(cards: [card])
    }
    
    func get(cardId: String) -> Card? {
        return cardMap[cardId]
    }
    
    func delete(cardId: String) {
        if cardMap[cardId] == nil {
            return
        }
        cardMap.removeValue(forKey: cardId)
    }
    
    func delete(card: Card) {
        self.delete(cardId: card.cardId)
    }
    
    func update(card: Card) {
        self.cardMap.updateValue(card, forKey: card.cardId)
    }
    
    func add(cards: [Card]) {
        for card in cards {
            self.cardMap[card.cardId] = card
        }
    }
    
    func rename(deckName: String) {
        name = deckName
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
        
        for card in cards {
            if Date.isSmallerThan(card.dateToShow, date) {
                cardDues.append(CardDue(card: card))
            }
        }
        
        return cardDues.sorted()
    }
    
    func search(text: String) -> [CardDue] {
        var searchResults:[CardDue] = []
        let temp = text.characters.map { String($0) }
        var regex = temp.joined(separator: ".*")
        regex = ".*\(regex).*"
        
        for card in cards {
            var isMatch = false
            isMatch = isMatch || regex.matches(text: card.answer)
            isMatch = isMatch || regex.matches(text: card.question)
            if isMatch {
                searchResults.append(CardDue(card:card))
            }
        }
        
        return searchResults
    }
}
