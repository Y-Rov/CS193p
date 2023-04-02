//
//  SetGameView.swift
//  Set
//
//  Created by user on 3/11/23.
//
import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetStandardGame
    
    var body: some View {
        VStack {
            header
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card, game: game)
                    .padding(4)
            }
        }
        .padding(.horizontal)
    }
    
    var header: some View {
        HStack {
            Button(action: {
                game.dealThreeMoreCards()
            }, label: {
                Text("Deal 3 More Cards")
            })
            .disabled(game.isDealThreeMoreCardsDisabled)
            
            Spacer()
            Button(action: {
                game.start()
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View {
    let card: SetStandardGame.Card
    let game: SetStandardGame
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)
                
                if card.isIncludedInSet {
                    shape.strokeBorder(lineWidth: increasedLineWidth()).foregroundColor(.gray.opacity(1))
                } else {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(.gray)
                }
                
                if game.status == .final {
                    if card.state == .final {
                        shape.strokeBorder(lineWidth: increasedLineWidth()).foregroundColor(.green)
                    } else {
                        shape.strokeBorder(lineWidth: increasedLineWidth()).foregroundColor(.red)
                    }
                }
                
                VStack {
                    Text(String(card.content.numberOfShapes))
                    Text(card.content.shading)
                    Text(card.content.color)
                    Text(card.content.shape)
                }
            }
            .onTapGesture {
                game.choose(card)
            }
        }
    }
    
    private func increasedLineWidth() -> CGFloat {
        DrawingConstants.lineWidth + DrawingConstants.lineWidthShift
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1
        static let fontScale: CGFloat = 0.7
        static let opacity = 0.5
        static let lineWidthShift: CGFloat = 2
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let setGame = SetStandardGame()
        SetGameView(game: setGame)
    }
}
