//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 2023-02-11.
//

import SwiftUI

struct ContentView: View {
    var vehicles = ["🚄", "🚃", "🚠", "🚌", "🚎", "🚗", "🏎", "🏍", "🚑", "🚲", "🚂", "🛸", "🚁"]
    var buildings = ["🏠", "🏨", "💒", "🏣", "🏭", "🏪", "🏦", "🕌", "🏩", "🏛", "🏬", "🕍", "🏥", "⛩"]
    var food = ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍓", "🍒", "🥥", "🍑", "🍆", "🥑", "🥦", "🥕", "🥐"]
    var animals = ["🐍", "🦎", "🦖", "🐙", "🐳", "🐬", "🐊", "🐝", "🐴", "🐺", "🦇", "🦋", "🦆", "🦄", "🐉", "🐈"]
    
    @State var emojis = ["🚄", "🚃", "🚠", "🚌", "🚎", "🚗", "🏎", "🏍", "🚑", "🚲", "🚂", "🛸", "🚁"]
    
    @State var emojiCount = 4;
    let minEmojiCount = 4;
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding(.vertical)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                vehicleThemeButton
                Spacer()
                buildingThemeButton
                Spacer()
                foodThemeButton
                Spacer()
                animalThemeButton
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    var vehicleThemeButton: some View {
        Button(action: {
            emojis = vehicles.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<vehicles.count)
        }, label: {
            createButtonLabel(imageName: "car", caption: "Vehicles")
        })
    }
    
    var buildingThemeButton: some View {
        Button(action: {
            emojis = buildings.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<buildings.count)
        }, label: {
            createButtonLabel(imageName: "house", caption: "Buildings")
        })
    }
    
    var foodThemeButton: some View {
        Button(action: {
            emojis = food.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<food.count)
        }, label: {
            createButtonLabel(imageName: "fork.knife", caption: "Food")
        })
    }
    
    var animalThemeButton: some View {
        Button(action: {
            emojis = animals.shuffled()
            emojiCount = Int.random(in: minEmojiCount..<animals.count)
        }, label: {
            createButtonLabel(imageName: "pawprint", caption: "Animals")
        })
    }
    
    func createButtonLabel(imageName: String, caption: String) -> some View {
        VStack {
            Image(systemName: imageName)
                .font(.largeTitle)
            Text(caption)
                .font(.caption)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14")
            .preferredColorScheme(.light)
        ContentView()
            .previewDevice("iPhone 14 Plus")
            .preferredColorScheme(.light)
        ContentView()
            .previewDevice("iPhone 14 Pro")
            .preferredColorScheme(.dark)
        ContentView()
            .previewDevice("iPhone 14 Pro Max")
            .preferredColorScheme(.dark)
    }
}
