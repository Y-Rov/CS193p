//
//  SetStandardGame.swift
//  Set
//
//  Created by user on 3/12/23.
//

import SwiftUI

class SetStandardGame: ObservableObject {
    typealias Card = SetGame<SetCardContent>.Card
    
    private static let numbersOfShapes = 1...3
    private static let shapes = ["diamond", "squiggle", "oval"]
    private static let shadings = ["solid", "striped", "open"]
    private static let colors = ["red", "green", "purple"]
    
    private static var startGameDeck: Array<SetCardContent> = []
    private var currentGameDeck: Array<SetCardContent>
    
    @Published private var setGame: SetGame<SetCardContent>
    
    var cards: Array<Card> {
        setGame.cards
    }
    
    var status: SetState? {
        setGame.currentSetState
    }
    
    @Published private(set) var isDealThreeMoreCardsDisabled = false
    
    private static func createSetGame(with firstTwelveCards: ArraySlice<SetCardContent>) -> SetGame<SetCardContent> {
        SetGame<SetCardContent>(numberOfCards: GameConstants.startCardsQuantity) { index in
            firstTwelveCards[index]
        }
    }
    
    init() {
        SetStandardGame.startGameDeck.reserveCapacity(GameConstants.allCardsQuantity)
        for number in SetStandardGame.numbersOfShapes {
            for shape in SetStandardGame.shapes {
                for shading in SetStandardGame.shadings {
                    for color in SetStandardGame.colors {
                        SetStandardGame.startGameDeck.append(SetCardContent(numberOfShapes: number, shading: shading,
                                                                            color: color, shape: shape))
                    }
                }
            }
        }
        currentGameDeck = SetStandardGame.startGameDeck.shuffled()
        setGame = SetStandardGame.createSetGame(with: currentGameDeck[0..<GameConstants.startCardsQuantity])
        currentGameDeck.removeSubrange(0..<GameConstants.startCardsQuantity)
    }
    
    private struct GameConstants {
        static let allCardsQuantity = 81
        static let startCardsQuantity = 12
        static let three = 3
    }
    
    // MARK: - Intents
    func start() {
        let shuffledDeck = SetStandardGame.startGameDeck.shuffled()
        setGame = SetStandardGame.createSetGame(with: shuffledDeck[0..<GameConstants.startCardsQuantity])
        currentGameDeck = shuffledDeck
        currentGameDeck.removeSubrange(0..<GameConstants.startCardsQuantity)
        isDealThreeMoreCardsDisabled = false
    }
    
    func dealThreeMoreCards() {
        let randomIndex = Int.random(in: 0...currentGameDeck.count - GameConstants.three)
        setGame.addThreeMoreCards(from: currentGameDeck[randomIndex..<randomIndex + GameConstants.three])
        removeThreeCardsFromCurrentDeck(startIndex: randomIndex)
    }
    
    func choose(_ card: Card) {
        setGame.choose(card)
    }
    
    private func removeThreeCardsFromCurrentDeck(startIndex: Int) {
        currentGameDeck.removeSubrange(startIndex..<startIndex + GameConstants.three)
        if currentGameDeck.isEmpty {
            isDealThreeMoreCardsDisabled = true
        }
    }
}
