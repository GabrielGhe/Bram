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
    
    func testAddSchedule() {
        var card1 = Card.Builder()
            .setId("1")
            .setQuestion("question 1")
            .setAnswer("answer 1")
            .build()
        
        var card2 = Card.Builder()
            .setCard(card1)
            .setId("2")
            .build()
        
        var card3 = Card.Builder()
            .setCard(card1)
            .setId("3")
            .build()
        
        var card4 = Card.Builder()
            .setCard(card1)
            .setId("4")
            .build()
        
        var card5 = Card.Builder()
            .setCard(card1)
            .setId("5")
            .setDaysToWait(5)
            .build()
        
        var card6 = Card.Builder()
            .setCard(card1)
            .setId("6")
            .setDaysToWait(5)
            .build()
        
        var card7 = Card.Builder()
            .setCard(card1)
            .setId("7")
            .setDaysToWait(5)
            .build()
        
        var card8 = Card.Builder()
            .setCard(card1)
            .setId("8")
            .setDaysToWait(5)
            .build()
        
        card1 = Scheduler.scheduleShowTime(card: card1, answer: TimeAdded.BAD)
        card2 = Scheduler.scheduleShowTime(card: card2, answer: TimeAdded.OK)
        card3 = Scheduler.scheduleShowTime(card: card3, answer: TimeAdded.GOOD)
        card4 = Scheduler.scheduleShowTime(card: card4, answer: TimeAdded.GREAT)
        
        card5 = Scheduler.scheduleShowTime(card: card5, answer: TimeAdded.BAD)
        card6 = Scheduler.scheduleShowTime(card: card6, answer: TimeAdded.OK)
        card7 = Scheduler.scheduleShowTime(card: card7, answer: TimeAdded.GOOD)
        card8 = Scheduler.scheduleShowTime(card: card8, answer: TimeAdded.GREAT)
        
        let deck = Deck(name: "Deck1")
        deck.addCards([card1, card2, card3, card4, card5, card6, card7, card8])
        
        let cards1day = deck.removeCardsDue(Date().addDays(1))
        let cards2days = deck.removeCardsDue(Date().addDays(2))
        let cards3days = deck.removeCardsDue(Date().addDays(3))
        
        let cards6days = deck.removeCardsDue(Date().addDays(6))
        let cards8days = deck.removeCardsDue(Date().addDays(8))
        let cards10days = deck.removeCardsDue(Date().addDays(10))
        
        XCTAssertEqual(cards1day.count, 2, "There should be two cards for tomorrow, 1 and 5")
        XCTAssertEqual(cards2days.count, 2, "There should be two cards for 2 days from now, 2 and 3")
        XCTAssertEqual(cards3days.count, 1, "There should be one card for 3 days from now")
        XCTAssertEqual(cards6days.count, 1, "There should be one card for 6 days from now")
        XCTAssertEqual(cards8days.count, 1, "There should be one card for 8 days from now")
        XCTAssertEqual(cards10days.count, 1, "There should be one card for 10 days from now")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
