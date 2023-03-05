//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Admin on 2023-02-11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            header
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))], spacing: 8) {
                    ForEach(game.cards) { card in
                        CardView(card: card, gradient: game.themeColors)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .padding(.horizontal)
            Text("Theme: " + game.themeName)
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    var header: some View {
        HStack {
            Text("Score: " + String(game.playerScore))
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                game.start()
            }, label: {
                Text("New game")
            })
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    // Extra Credit 3
    let gradient: Gradient
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                // Extra Credit 3
                shape.fill(gradient)
            }
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiGame = EmojiMemoryGame()
        
        EmojiMemoryGameView(game: emojiGame)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: emojiGame)
            .preferredColorScheme(.dark)
    }
}
