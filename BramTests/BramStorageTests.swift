//
//  BramStorageTests.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-04.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import XCTest

@testable import Bram

class BramStorageTests: XCTestCase {
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
}

