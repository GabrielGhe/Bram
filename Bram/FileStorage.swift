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
            cards.append(card)
        }
        
        return cards
    }
    
    func getCards(forDeck deckId: String) -> [Card] {
        let results = realm.objects(Card.self).filter("deckId == \(deckId)")
        var cards: [Card] = []
        
        for card in results {
            cards.append(card)
        }
        
        return cards
    }
    
    func getCard(byId id: String) -> Card? {
        let predicate = NSPredicate(format: "cardId = %@", id)
        let card = realm.objects(Card.self).filter(predicate).first
        return card
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
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    // MARK: Helper Methods
}
