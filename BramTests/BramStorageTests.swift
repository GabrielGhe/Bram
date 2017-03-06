//
//  BramStorageTests.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-04.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import XCTest
import RealmSwift

@testable import Bram

class BramStorageTests: XCTestCase {
    
    let TEST_DECK = "testDeckName123"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetDecks() {
        let storage = StubStorage()
        let deckCount = 3
        
        XCTAssertEqual(storage.getDecks().count, deckCount, "Should retrieve 3 decks")
    }
    
    func testGetCards1() {
        let storage = StubStorage()
        let deckChineseCardCount = 3
        let chineseDeck = storage.getDecks()[0]
        
        XCTAssertEqual(chineseDeck.cards.count, deckChineseCardCount, "Should retrieve 3 cards")
    }
    
    func testGetCards2() {
        let storage = StubStorage()
        let deckLifeCardCount = 4
        let lifeDeck = storage.getDecks()[1]
        
        XCTAssertEqual(lifeDeck.cards.count, deckLifeCardCount, "Should retrieve 4 cards")
    }
    
    func testGetCards3() {
        let storage = StubStorage()
        let deckSchoolCardCount = 2
        let schoolDeck = storage.getDecks()[2]
        
        XCTAssertEqual(schoolDeck.cards.count, deckSchoolCardCount, "Should retrieve 2 cards")
    }
    
    func testRealStorage() {
        let storage = FileStorage()
        let card1 = CardBuilder()
            .setCardId("1")
            .setDeckId(TEST_DECK)
            .setQuestion("ni xian wo le")
            .setAnswer("Did you miss me")
            .setDateToShow(Date.e.addDays(4))
            .build()
        
        storage.save(card: card1)
        guard let retrievedCard = storage.getCard(byId: card1.cardId) else {
            XCTAssertEqual(false, true, "Did not retrieve a card")
            return
        }
        
        XCTAssertEqual(retrievedCard.deckId, card1.deckId, "Should retrieve same deckId")
        XCTAssertEqual(retrievedCard.question, card1.question, "Should retrieve same deckId")
        
        storage.delete(card: card1)
        let cards = storage.getCards(forDeck: TEST_DECK)
        XCTAssertEqual(cards.count, 0, "Should be empty")
    }
}

