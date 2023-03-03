//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Admin on 2023-02-14.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚄", "🚃", "🚠", "🚌", "🚎", "🚗", "🏎", "🏍", "🚑", "🚲", "🚂", "🛸", "🚁", "✈️"]
    
    static let themes: [MemorizeTheme] = [
        MemorizeTheme(name: "Transport", emojis: ["🚄", "🚃", "🚠", "🚌", "🚎", "🚗"], numberOfPairsOfCards: 4, color: "blue"),
        MemorizeTheme(name: "Sport", emojis: ["⚽️", "🏀", "🏈", "⚾️"], numberOfPairsOfCards: 23, color: "red"),
        MemorizeTheme(name: "Food", emojis: ["🍓", "🍋", "🍐", "🍉", "🍏"], numberOfPairsOfCards: 5, color: "green"),
        MemorizeTheme(name: "Drinks", emojis: ["☕️", "🍷", "🍺", "🍸", "🍹", "🍾", "🥛"], numberOfPairsOfCards: 7, color: "brown"),
        MemorizeTheme(name: "People", emojis: ["🧕", "👮‍♀️", "👩‍🎓", "👷‍♂️", "👩‍🏫", "👩‍🏭", "👩‍🚒", "👩‍💻"], numberOfPairsOfCards: 7, color: "yellow"),
        MemorizeTheme(name: "Devices", emojis: ["⌚️", "📱", "💻", "🖥", "🖱", "💾"], numberOfPairsOfCards: 6, color: "black"),
        MemorizeTheme(name: "Flags", emojis: ["🇦🇹", "🇹🇩", "🇧🇬", "🇨🇿", "🇮🇪", "🇺🇦", "🇺🇸", "🇬🇧", "🇪🇸"], numberOfPairsOfCards: 9, color: "orange")
    ]
    
    static func createMemoryGame(with gameTheme: MemorizeTheme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: gameTheme.numberOfPairsOfCards) { pairIndex in
            gameTheme.emojis[pairIndex]
        }
    }
    
    @Published private var currentGameTheme: MemorizeTheme
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    init() {
        var randomGameTheme = EmojiMemoryGame.themes.randomElement()!
        if randomGameTheme.numberOfPairsOfCards > randomGameTheme.emojis.count {
            randomGameTheme.numberOfPairsOfCards = randomGameTheme.emojis.count
        }
        
        currentGameTheme = randomGameTheme
        model = EmojiMemoryGame.createMemoryGame(with: randomGameTheme)
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func chooseRandomTheme() {
        
    }
}
