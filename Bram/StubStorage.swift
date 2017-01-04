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
    
    public var decks: [Deck] {
        return internalDecks
    }
    
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
    
    func save(deck: Deck) {
        
    }
    
    func save(card: Card) {
        
    }
    
    // MARK: Helped methods
    
    fileprivate func populateChineseDeck(deck: Deck) {
        let card1 = Card.Builder()
            .setCardId("1")
            .setDeckId(deck.deckId)
            .setQuestion("ni xian wo le")
            .setAnswer("Did you miss me")
            .setDateToShow(Date.e.addDays(4))
            .build()
        
        let card2 = Card.Builder()
            .setCardId("2")
            .setDeckId(deck.deckId)
            .setQuestion("wo ai ni")
            .setAnswer("I love you")
            .setDateToShow(Date.e.addDays(3))
            .build()
        
        let card3 = Card.Builder()
            .setCardId("3")
            .setDeckId(deck.deckId)
            .setQuestion("ni xiang qu nali")
            .setAnswer("where do you want to go")
            .build()
        
        deck.add(card: card1)
        deck.add(card: card2)
        deck.add(card: card3)
    }
    
    fileprivate func populateLifeDeck(deck: Deck) {
        let card1 = Card.Builder()
            .setCardId("4")
            .setDeckId(deck.deckId)
            .setQuestion("Word for 4")
            .setAnswer("Arrow")
            .setDateToShow(Date.e.addDays(2))
            .build()
        
        let card2 = Card.Builder()
            .setCardId("5")
            .setDeckId(deck.deckId)
            .setQuestion("Word for 7")
            .setAnswer("Cow")
            .setDateToShow(Date.e.addDays(6))
            .build()
        
        let card3 = Card.Builder()
            .setCardId("6")
            .setDeckId(deck.deckId)
            .setQuestion("Word for 9")
            .setAnswer("Bee")
            .build()
        
        let card4 = Card.Builder()
            .setCardId("7")
            .setDeckId(deck.deckId)
            .setQuestion("Word for 0")
            .setAnswer("Saw")
            .build()
        
        deck.add(card: card1)
        deck.add(card: card2)
        deck.add(card: card3)
        deck.add(card: card4)
    }
    
    fileprivate func populateSchoolDeck(deck: Deck) {
        let card1 = Card.Builder()
            .setCardId("8")
            .setDeckId(deck.deckId)
            .setQuestion("What is top down programming?")
            .setAnswer("Define the methods first before continuing")
            .setDateToShow(Date.e.addDays(5))
            .build()
        
        let card2 = Card.Builder()
            .setCardId("9")
            .setDeckId(deck.deckId)
            .setQuestion("What is SLAP?")
            .setAnswer("Single layer of abstraction per level")
            .build()
        
        deck.add(card: card1)
        deck.add(card: card2)
    }
}
