//
//  FileStorage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-04.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import RealmSwift

class FileStorage : Storage {
    
    // MARK: Variables
    let realm = try! Realm()
    
    // MARK: Storage
    
    func getDecks() -> [Deck] {
        let results = realm.objects(Deck.self)
        var decks: [Deck] = []
        
        for deck in results {
            //TODO make deep copy of deck
            let cards = getCards(forDeck: deck.deckId)
            deck.add(cards: cards)
            decks.append(deck)
        }
        
        return decks
    }
    
    func getCards() -> [Card] {
        let results = realm.objects(Card.self)
        var cards: [Card] = []
        
        for card in results {
            let cardDeepCopy = CardBuilder().set(otherCard: card).build()
            cards.append(cardDeepCopy)
        }
        
        return cards
    }
    
    func getCards(forUserId userId: String) -> [Card] {
        let results = realm.objects(Card.self).filter("deckId = %@", userId)
        var cards: [Card] = []
        
        for card in results {
            let cardDeepCopy = CardBuilder().set(otherCard: card).build()
            cards.append(cardDeepCopy)
        }
        
        return cards
    }
    
    func getDecks(forUserId userId: String) -> [Deck] {
        let results = realm.objects(Deck.self).filter("userId = %@", userId)
        var decks: [Deck] = []
        
        //TODO make deep copy of deck
        for deck in results {
            decks.append(deck)
        }
        
        return decks
    }
    
    func getCards(forDeck deckId: String) -> [Card] {
        let results = realm.objects(Card.self).filter("userId = %@", deckId)
        var cards: [Card] = []
        
        for card in results {
            let cardDeepCopy = CardBuilder().set(otherCard: card).build()
            cards.append(cardDeepCopy)
        }
        
        return cards
    }
    
    func getCard(byId id: String) -> Card? {
        let predicate = NSPredicate(format: "cardId = %@", id)
        let maybeCard = realm.objects(Card.self).filter(predicate).first
        
        guard let card = maybeCard else {
            return Optional<Card>.none
        }
        
        return CardBuilder().set(otherCard: card).build()
    }
    
    func save(deck: Deck) {
        try! realm.write {
            realm.add(deck)
        }
    }
    
    func save(card: Card) {
        try! realm.write {
            realm.add(card)
        }
        let cards = getCards()
    }
    
    func delete(deck: Deck) {
        try! realm.write {
            realm.delete(deck)
        }
    }
    
    func delete(card: Card) {
        try! realm.write {
            realm.delete(card)
        }
    }
    
    func deleteDecks(forUserId: String) {
        
    }
    
    func deleteCards(forUserId: String) {
        
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    // MARK: Helper Methods
}
