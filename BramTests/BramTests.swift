//
//  BramTests.swift
//  BramTests
//
//  Created by Gabriel Gheorghian on 2016-08-28.
//  Copyright © 2016 GabrielGhe. All rights reserved.
//

import XCTest
import SwiftPriorityQueue
@testable import Bram

class BramTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCardMorePriorityThanOther() {
        let card1 = Card.Builder()
            .setId("1234")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        let card2 = Card.Builder()
            .setId("2345")
            .setQuestion("question 2")
            .setAnswer("answer 2")
            .setDateToShow(Date().addDays(1))
            .build()
        XCTAssertTrue(card1 > card2, "Card 1 should have priority over card 2")
    }
    
    func testPeek() {
        let card1 = Card.Builder()
            .setId("1234")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        let card2 = Card.Builder()
            .setId("2345")
            .setQuestion("question 2")
            .setAnswer("answer 2")
            .setDateToShow(Date().addDays(1))
            .build()
        
        var queue = PriorityQueue<Card>(ascending: false)
        
        queue.push(card1)
        queue.push(card2)
        
        XCTAssertTrue(queue.peek() == card1, "Card 1 should be the card that pops up first")
    }
    
    func testGetCardsDue() {
        let card1 = Card.Builder()
            .setId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        let card2 = Card.Builder()
            .setCard(card1)
            .setId("2")
            .setDateToShow(Date().addDays(1))
            .build()
        
        let card3 = Card.Builder()
            .setCard(card1)
            .setId("3")
            .setDateToShow(Date().addDays(1))
            .build()
        
        let card4 = Card.Builder()
            .setCard(card1)
            .setId("4")
            .setDateToShow(Date().addDays(2))
            .build()
        
        let deck: Deck = Deck(name: "Test1")
        deck.addCards([card1, card2, card3, card4])
        XCTAssertEqual(deck.getCardsDue().count, 3, "There should only be 3 cards due today")
    }
    
    func testTimeDifference() {
        let today = Date()
        let oneDay = Date().addDays(1)
        let twoDays = Date().addDays(2)
        let tenDays = Date().addDays(10)
        
        assert(Date.isSmallerThan(today, oneDay), "today should be within the range")
        assert(Date.isSmallerThan(oneDay, twoDays), "oneDay should be within the range")
        assert(!Date.isSmallerThan(tenDays, today), "tenDays should not be within the range")
        assert(Date.isSmallerThan(today, tenDays), "today should be within the range")
        assert(Date.isSmallerThan(oneDay, today), "oneDay should be within the range")
        assert(!Date.isSmallerThan(twoDays, today), "twoDay should not be within the range")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
