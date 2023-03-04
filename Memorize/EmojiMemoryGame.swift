//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Admin on 2023-02-14.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes: [MemorizeTheme] = [
        MemorizeTheme(name: "Transport", emojis: ["🚄", "🚃", "🚠"], numberOfPairsOfCards: 4, color: "blue"),
        MemorizeTheme(name: "Sport", emojis: ["⚽️", "🏀", "🏈", "⚾️"], numberOfPairsOfCards: 23, color: "red"),
        MemorizeTheme(name: "Food", emojis: ["🍓", "🍋", "🍐", "🍉", "🍏"], numberOfPairsOfCards: 5, color: "fuchsia"),
        MemorizeTheme(name: "Drinks", emojis: ["🍷", "🍺", "🍸", "🍹", "🍾", "🥛"], numberOfPairsOfCards: 7, color: "brown"),
        MemorizeTheme(name: "People", emojis: ["👮‍♀️", "👩‍🎓", "👷‍♂️", "👩‍🏫", "👩‍🏭", "👩‍🚒", "👩‍💻"], numberOfPairsOfCards: 7, color: "yellow"),
        MemorizeTheme(name: "Devices", emojis: ["⌚️", "📱", "💻", "🖥", "🖱", "💾", "📷", "⏳"], numberOfPairsOfCards: 6, color: "black"),
        MemorizeTheme(name: "Flags", emojis: ["🇦🇹", "🇹🇩", "🇧🇬", "🇨🇿", "🇮🇪", "🇺🇦", "🇺🇸", "🇬🇧", "🇪🇸"], numberOfPairsOfCards: 9, color: "orange"),
        MemorizeTheme(name: "Symbols", emojis: ["❤️", "💖", "✡️", "☯️", "♋️", "💔", "❤️‍🩹", "💕", "🆘", "⛔️"], numberOfPairsOfCards: 9, color: "purple"),
        MemorizeTheme(name: "Nature", emojis: ["🪷", "🌸", "🌻", "🌹", "🪴", "🐚", "🍄", "🍀", "🌵", "🎄"], numberOfPairsOfCards: 10, color: "green"),
        MemorizeTheme(name: "Animals", emojis: ["🐝", "🐌", "🐜", "🦄", "🦅", "🐳", "🦣", "🐬", "🐍"], numberOfPairsOfCards: 9, color: "cyan")
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
        "cyan": Color.cyan
    ]
    
    private static func createMemoryGame(with theme: MemorizeTheme) -> MemoryGame<String> {
        let shuffledThemeEmojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            shuffledThemeEmojis[pairIndex]
        }
    }
    
    @Published private var currentGameTheme: MemorizeTheme
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var playerScore: Int {
        model.score
    }
    
    var themeName: String {
        currentGameTheme.name
    }
    
    var themeColor: Color {
        let color = EmojiMemoryGame.colors[currentGameTheme.color]
        if color == nil {
            return Color.red
        }
        
        return color!
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
    
    func start() {
        var randomGameTheme = EmojiMemoryGame.themes.randomElement()!
        while randomGameTheme.name == currentGameTheme.name {
            randomGameTheme = EmojiMemoryGame.themes.randomElement()!
        }
        
        if randomGameTheme.numberOfPairsOfCards > randomGameTheme.emojis.count {
            randomGameTheme.numberOfPairsOfCards = randomGameTheme.emojis.count
        }
        
        currentGameTheme = randomGameTheme
        model = EmojiMemoryGame.createMemoryGame(with: randomGameTheme)
    }
}
