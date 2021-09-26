//
//  ContentView.swift
//  Memorise
//
//  Created by Philip Rose on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["✈️", "🚃", "🚗", "⛴", "🚛", "🚚", "🚙", "🚕", "🚓", "🏍", "🚲", "🛳", "🚢", "🚤", "⛵️", "🛶"]
    @State var emojiCount = 16
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 200))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            Spacer()
        }
        .padding(.horizontal)
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
