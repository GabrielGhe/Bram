//
//  BramStorageTests.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-04.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import XCTest
import RealmSwift
import Realm

@testable import Bram

class BramStorageTests: XCTestCase {
    
    fileprivate let TEST_DECK = "testDeckName123"
    fileprivate let TEST_USER_ID = "TestId"
    
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
            .set(userId: TEST_USER_ID)
            .set(cardId: "1")
            .set(deckId: TEST_DECK)
            .set(question: "ni xian wo le")
            .set(answer: "Did you miss me")
            .set(dateToShow: Date.e.addDays(4))
            .build()
        
        storage.save(card: card1)
        guard let retrievedCard = storage.getCard(byId: card1.cardId) else {
            XCTAssertEqual(false, true, "Did not retrieve a card")
            return
        }
        
        XCTAssertEqual(retrievedCard.deckId, card1.deckId, "Should retrieve same deckId")
        XCTAssertEqual(retrievedCard.question, card1.question, "Should retrieve same question")
        XCTAssertEqual(retrievedCard.answer, card1.answer, "Should retrieve same answer")
        
        storage.delete(card: card1)
        let cards = storage.getCards(forDeck: TEST_DECK)
        XCTAssertEqual(cards.count, 0, "Should be empty")
    }
    
    func testRealStorageNoData() {
        let storage = FileStorage()
        let card1 = CardBuilder()
            .set(deckId: TEST_DECK)
            .set(userId: TEST_USER_ID)
            .set(question: "ni xian wo le")
            .set(answer: "Did you miss me")
            .build()
        
        storage.save(card: card1)
        guard let retrievedCard = storage.getCard(byId: card1.cardId) else {
            XCTAssertEqual(false, true, "Did not retrieve a card")
            return
        }
        
        XCTAssertEqual(retrievedCard.deckId, card1.deckId, "Should retrieve same deckId")
        XCTAssertEqual(retrievedCard.question, card1.question, "Should retrieve same question")
        XCTAssertEqual(retrievedCard.answer, card1.answer, "Should retrieve same answer")
        
        storage.delete(card: card1)
        let cards = storage.getCards(forDeck: TEST_DECK)
        XCTAssertEqual(cards.count, 0, "Should be empty")
    }
    
    func testRealStorageUserId() {
        let storage = FileStorage()
        let card1 = CardBuilder()
            .set(userId: TEST_USER_ID)
            .set(deckId: TEST_DECK)
            .set(question: "ni xian wo le")
            .set(answer: "Did you miss me")
            .build()
    }
}

