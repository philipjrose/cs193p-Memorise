//
//  ContentView.swift
//  Memorise
//
//  Created by Philip Rose on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojiCount = 16
    
    var themes: [CardTheme] = [
        CardTheme(title: "Vehicles", imageName: "tram.fill", emojis: ["✈️", "🚃", "🚗", "⛴", "🚛", "🚚", "🚙", "🚕", "🚓", "🏍", "🚲", "🛳", "🚢", "🚤", "⛵️", "🛶"]),
        CardTheme(title: "Pets", imageName: "pawprint.fill", emojis: ["🐱", "🐶", "🐷", "🐍", "🐴", "🐮", "🐹", "🐥"]),
        CardTheme(title: "Expressions", imageName: "face.smiling.fill", emojis: ["😬", "🙂", "😎", "😂", "😆", "😉", "🤨", "😫", "😡", "😧"])]
    @State var selectedThemeTitle: String = "Expressions"
    
    let minCardsToShow = 4
    
    func getSelectedTheme() -> CardTheme {
        themes.first(where: { $0.title == selectedThemeTitle })!
    }
    
    func setSelectedTheme(newThemeTitle: String) {
        selectedThemeTitle = newThemeTitle
    }
    
    var body: some View {
        VStack {
            Text("Memorise").font(.largeTitle)
            ScrollView {
                let emojis = getSelectedTheme().emojis[0...(Int.random(in: minCardsToShow...getSelectedTheme().emojis.count)) - 1]
                    .shuffled()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: CGFloat(600 / emojis.count), maximum: CGFloat(800 / emojis.count)))]) {
                    ForEach(emojis, id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            .font(.largeTitle)
            Spacer()
            HStack {
                ForEach(themes, id: \.title) { theme in
                    VStack {
                        // Fix relative size of images
                        ThemeChooserButton(imageName: theme.imageName,
                                           title: theme.title,
                                           isSelected: theme.title == selectedThemeTitle)
                            .onTapGesture {
                                setSelectedTheme(newThemeTitle: theme.title)
                            }
                    }
                    .padding(.horizontal)
                    
                }
            }
        }
        .padding(.horizontal)
    }
    
    
}

struct CardTheme {
    var title: String
    var imageName: String
    var emojis: [String]
}

struct ThemeChooserButton: View {
    var imageName: String
    var title: String
    var isSelected: Bool
    
    var body: some View {
        VStack {
            // Fix relative size of images
            Image(systemName: imageName)
                .font(.system(size: 32))
                .padding(.vertical)
            Text(title)
                .font(.subheadline)
        }
        .foregroundColor(isSelected ? .accentColor : .primary)
    }
}

struct CardView: View {
    @State var isFaceUp = true
    var content: String
    
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
            .preferredColorScheme(.dark)
        
        ContentView()
            .preferredColorScheme(.light)
    }
}
