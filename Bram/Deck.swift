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
    dynamic var userId: String = ""
    private var cardMap: [String:Card] = [:]
    dynamic var name: String = ""
    dynamic var deckId: String = ""
    dynamic var cardsPerDay: Int = 10
    dynamic var creationDate: Date = Date.s
    
    public var cardIds: [String] {
        return cardMap.keys.sorted()
    }
    
    public var cards: [Card] {
        return cardMap.values.sorted()
    }
    
    convenience init(name: String) {
        self.init(userId: UIDevice.current.identifierForVendor!.uuidString, deckId: UUID().uuidString, name: name, cards: [], cardsPerDay: 10, creationDate: Date.s)
    }
    
    convenience init(userId: String, deckId: String, name: String, cards: [Card], cardsPerDay: Int, creationDate: Date) {
        self.init()
        self.deckId = deckId
        self.name = name
        self.cardsPerDay = cardsPerDay
        self.cardMap = [:]
        self.creationDate = creationDate
        self.userId = userId
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
            for cardDue in mainCard.associatedCardIds {
                guard let card = cardMap[cardDue.cardId] else {
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
