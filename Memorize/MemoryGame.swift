//
//  MemoryGame.swift
//  Memorize
//
//  Created by Admin on 2023-02-14.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score: Int = 0
    private let matchValue: Int = 2
    private let penaltyValue: Int = -1
    // Extra Credit 4
    private var firstChosenCardTime: Date = Date.now
    
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
                    
                cards[chosenIndex].alreadyBeenSeen = true
                cards[potentialMatchIndex].alreadyBeenSeen = true
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                firstChosenCardTime = Date.now
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var alreadyBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
