//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Admin on 2023-02-14.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let themes = [
        MemorizeTheme(name: "Transport", emojis: ["🚄", "🚃", "🚠"], numberOfPairsOfCards: 4, colors: ["orange"]),
        MemorizeTheme(name: "Sport", emojis: ["⚽️", "🏀", "🏈", "⚾️"], numberOfPairsOfCards: 23, colors: ["red", "green"]),
        MemorizeTheme(name: "Food", emojis: ["🍓", "🍋", "🍐", "🍉", "🍏"], colors: ["fuchsia"]),
        MemorizeTheme(name: "Drinks", emojis: ["🍷", "🍺", "🍸", "🍹", "🍾", "🥛"], numberOfPairsOfCards: 7, colors: ["brown"]),
        MemorizeTheme(name: "People", emojis: ["👮‍♀️", "👩‍🎓", "👷‍♂️", "👩‍🏫", "👩‍🏭", "👩‍🚒", "👩‍💻"], isNumberOfPairsOfCardsRandom: true, colors: ["yellow"]),
        MemorizeTheme(name: "Devices", emojis: ["⌚️", "📱", "💻", "🖥", "🖱", "💾", "📷", "⏳"], numberOfPairsOfCards: 6, colors: ["black"]),
        MemorizeTheme(name: "Flags", emojis: ["🇦🇹", "🇹🇩", "🇧🇬", "🇨🇿", "🇮🇪", "🇺🇦", "🇺🇸", "🇬🇧", "🇪🇸"], numberOfPairsOfCards: 9, colors: ["blue", "yellow"]),
        MemorizeTheme(name: "Symbols", emojis: ["❤️", "💖", "✡️", "☯️", "♋️", "💔", "❤️‍🩹", "💕", "🆘", "⛔️"], colors: ["purple"]),
        MemorizeTheme(name: "Nature", emojis: ["🪷", "🌸", "🌻", "🌹", "🪴", "🐚", "🍄", "🍀", "🌵", "🎄"], isNumberOfPairsOfCardsRandom: true, colors: ["green"]),
        MemorizeTheme(name: "Animals", emojis: ["🐝", "🐌", "🐜", "🦄", "🦅", "🐳", "🦣", "🐬", "🐍"], colors: ["green", "cyan"])
    ]
    
    private static let colors: [String: Color] = [
        "blue": Color.blue,
        "red": Color.red,
        "mint": Color.mint,
        "brown": Color.brown,
        "yellow": Color.yellow,
        "black": Color.black,
        "orange": Color.orange,
        "purple": Color.purple,
        "green": Color.green,
        "cyan": Color.cyan,
        "white": Color.white
    ]
    
    private static func createMemoryGame(with theme: MemorizeTheme) -> MemoryGame<String> {
        let shuffledThemeEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            shuffledThemeEmojis[pairIndex]
        }
    }
    
    @Published private var currentGameTheme: MemorizeTheme
    @Published private var model: MemoryGame<String>
    
    init() {
        var randomGameTheme = EmojiMemoryGame.themes.randomElement()!
        if randomGameTheme.numberOfPairsOfCards > randomGameTheme.emojis.count {
            randomGameTheme.numberOfPairsOfCards = randomGameTheme.emojis.count
        }
        
        currentGameTheme = randomGameTheme
        model = EmojiMemoryGame.createMemoryGame(with: randomGameTheme)
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var playerScore: Int {
        model.score
    }
    
    var themeName: String {
        currentGameTheme.name
    }
    
    var themeColors: Gradient {
        var themeColors = Array<Color>()
        for themeColor in currentGameTheme.colors {
            if let color = EmojiMemoryGame.colors[themeColor] {
                themeColors.append(color)
            } else {
                themeColors.append(.red)
            }
        }
        
        return Gradient(colors: themeColors)
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func start() {
        var randomGameTheme = EmojiMemoryGame.themes.randomElement()!
        while randomGameTheme.name == currentGameTheme.name {
            randomGameTheme = EmojiMemoryGame.themes.randomElement()!
        }
        
        if randomGameTheme.numberOfPairsOfCards > randomGameTheme.emojis.count {
            randomGameTheme.numberOfPairsOfCards = randomGameTheme.emojis.count
        }
        
        if randomGameTheme.isNumberOfPairsOfCardsRandom {
            randomGameTheme.numberOfPairsOfCards = Int.random(in: randomGameTheme.minNumberOfPairsOfCards...randomGameTheme.emojis.count)
        }
        
        currentGameTheme = randomGameTheme
        model = EmojiMemoryGame.createMemoryGame(with: randomGameTheme)
    }
}
