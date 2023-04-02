//
//  SetStandardGame.swift
//  Set
//
//  Created by user on 3/12/23.
//

import SwiftUI

class SetStandardGame: ObservableObject {
    typealias Card = SetGame.Card
    typealias GameState = SetGame.GameState
    
    private static let numbersOfShapes = 1...3
    private static let shapes = ["diamond", "squiggle", "oval"]
    private static let shadings = ["solid", "striped", "open"]
    private static let colors = ["red", "green", "purple"]
    
    private var startGameDeck: Array<SetStandardCardContent>
    
    @Published private var setGame: SetGame
    @Published private(set) var isDealThreeMoreCardsDisabled = false
    
    var cards: Array<Card> {
        setGame.cards
    }
    
    var status: GameState? {
        setGame.currentGameState
    }
    
    private static func createSetGame(deck: Array<SetStandardCardContent>) -> SetGame {
        let firstTwelveCards = deck[0..<GameConstants.startCardsQuantity]
        return SetGame(numberOfCards: GameConstants.startCardsQuantity, deck: deck) { index in
            firstTwelveCards[index]
        }
    }
    
    init() {
        startGameDeck = []
        startGameDeck.reserveCapacity(GameConstants.allCardsQuantity)
        for number in SetStandardGame.numbersOfShapes {
            for shading in SetStandardGame.shadings {
                for color in SetStandardGame.colors {
                    for shape in SetStandardGame.shapes {
                        startGameDeck.append(SetStandardCardContent(numberOfShapes: number, shading: shading, color: color, shape: shape))
                    }
                }
            }
        }
        //let shuffledDeck = startGameDeck.shuffled()
        let shuffledDeck = startGameDeck
        setGame = SetStandardGame.createSetGame(deck: shuffledDeck)
    }
    
    // MARK: - Intents
    func dealThreeMoreCards() {
        if setGame.addThreeMoreCards() {
            isDealThreeMoreCardsDisabled = true
        }
    }
    
    func start() {
        let shuffledDeck = startGameDeck.shuffled()
        setGame = SetStandardGame.createSetGame(deck: shuffledDeck)
        isDealThreeMoreCardsDisabled = false
    }
    
    func choose(_ card: Card) {
        setGame.choose(card)
    }
    
    // MARK: - Private constants
    private struct GameConstants {
        static let allCardsQuantity = 81
        static let startCardsQuantity = 12
        static let three = 3
    }
}
