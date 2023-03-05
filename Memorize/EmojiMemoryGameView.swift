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
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(gradient.stops.first!.color)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    // Extra Credit 3
                    shape.fill(gradient)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
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
