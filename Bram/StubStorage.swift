//
//  StubStorage.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2016-12-29.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import UIKit

class StubStorage : Storage {
    
    fileprivate var internalDecks:[Deck] = []
    fileprivate var TEST_USER_ID = "TestId"
    
    // MARK: Storage
    
    init() {
        let chineseDeck = Deck(name: "Chinese")
        let lifeDeck = Deck(name: "Life")
        let schoolDeck = Deck(name: "School")
        
        populateChineseDeck(deck: chineseDeck)
        populateLifeDeck(deck: lifeDeck)
        populateSchoolDeck(deck: schoolDeck)
        
        internalDecks = [chineseDeck, lifeDeck, schoolDeck]
    }
    
    func getDecks() -> [Deck] {
        return internalDecks
    }
    
    func getDecks(forUserId userId: String) -> [Deck] {
        var decks: [Deck] = []
        
        for tempDeck in getDecks() {
            if (tempDeck.userId == userId) {
                decks.append(tempDeck)
            }
        }
        return decks
    }
    
    func getCards(forUserId userId: String) -> [Card] {
        var cards: [Card] = []
        
        for tempDeck in getDecks() {
            if (tempDeck.userId == userId) {
                cards.append(contentsOf: tempDeck.cards)
            }
        }
        return cards
    }
    
    func getCards(forDeck deckId: String) -> [Card] {
        var cards: [Card] = []
        
        for tempDeck in getDecks() {
            if (tempDeck.deckId == deckId) {
                cards = tempDeck.cards
                break
            }
        }
        return cards
    }
    
    func deleteDecks(forUserId: String) {
        
    }
    
    func deleteCards(forUserId: String) {
        
    }
    
    func save(deck: Deck) {
        
    }
    
    func save(card: Card) {
        
    }
    
    // MARK: Helped methods
    
    fileprivate func populateChineseDeck(deck: Deck) {
        let card1 = CardBuilder()
            .set(cardId:"1")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"ni xian wo le")
            .set(answer:"Did you miss me")
            .set(dateToShow:Date.e.addDays(4))
            .build()
        
        let card2 = CardBuilder()
            .set(cardId:"2")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"wo ai ni")
            .set(answer:"I love you")
            .set(dateToShow:Date.e.addDays(3))
            .build()
        
        let card3 = CardBuilder()
            .set(cardId:"3")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"ni xiang qu nali")
            .set(answer:"where do you want to go")
            .build()
        
        deck.add(card: card1)
        deck.add(card: card2)
        deck.add(card: card3)
    }
    
    fileprivate func populateLifeDeck(deck: Deck) {
        let card1 = CardBuilder()
            .set(cardId:"4")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"Word for 4")
            .set(answer:"Arrow")
            .set(dateToShow:Date.e.addDays(2))
            .build()
        
        let card2 = CardBuilder()
            .set(cardId:"5")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"Word for 7")
            .set(answer:"Cow")
            .set(dateToShow:Date.e.addDays(6))
            .build()
        
        let card3 = CardBuilder()
            .set(cardId:"6")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"Word for 9")
            .set(answer:"Bee")
            .build()
        
        let card4 = CardBuilder()
            .set(cardId:"7")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"Word for 0")
            .set(answer:"Saw")
            .build()
        
        deck.add(card: card1)
        deck.add(card: card2)
        deck.add(card: card3)
        deck.add(card: card4)
    }
    
    fileprivate func populateSchoolDeck(deck: Deck) {
        let card1 = CardBuilder()
            .set(cardId:"8")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"What is top down programming?")
            .set(answer:"Define the methods first before continuing")
            .set(dateToShow:Date.e.addDays(5))
            .build()
        
        let card2 = CardBuilder()
            .set(cardId:"9")
            .set(userId: TEST_USER_ID)
            .set(deckId:deck.deckId)
            .set(question:"What is SLAP?")
            .set(answer:"Single layer of abstraction per level")
            .build()
        
        deck.add(card: card1)
        deck.add(card: card2)
    }
}
