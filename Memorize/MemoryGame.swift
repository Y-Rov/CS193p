//
//  MemoryGame.swift
//  Memorize
//
//  Created by Admin on 2023-02-14.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            } else {
                return nil
            }
        }
        set {
            firstChosenCardTime = Date.now
            for index in cards.indices {
                if index != newValue {
                    cards[index].isFaceUp = false
                } else {
                    cards[index].isFaceUp = true
                }
            }
        }
    }
    private(set) var score = 0
    private let matchValue = 2
    private let penaltyValue = -1
    // Extra Credit 4
    private var firstChosenCardTime = Date.now
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                let secondChosenCardTime = Date.now
                // Extra Credit 4
                let timeScoreValue = max(10 - Int(secondChosenCardTime.timeIntervalSince(firstChosenCardTime).rounded(.toNearestOrAwayFromZero)), 1)
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += matchValue * timeScoreValue
                } else {
                    let finalPenaltyValue = penaltyValue * timeScoreValue
                    score += cards[chosenIndex].alreadyBeenSeen ? finalPenaltyValue : Int.zero
                    score += cards[potentialMatchIndex].alreadyBeenSeen ? finalPenaltyValue : Int.zero
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].alreadyBeenSeen = true
                cards[potentialMatchIndex].alreadyBeenSeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        var notShuffledCards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            notShuffledCards.append(Card(content: content, id: pairIndex * 2))
            notShuffledCards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = notShuffledCards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var alreadyBeenSeen = false
        let content: CardContent
        let id: Int
    }
}
