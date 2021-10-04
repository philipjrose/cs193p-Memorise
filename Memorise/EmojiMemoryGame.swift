//
//  EmojiMemoryGame.swift
//  Memorise
//
//  Created by Philip Rose on 9/24/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Theme = MemoryGame<String>.Theme
    typealias ThemeColour = MemoryGame<String>.ThemeColour
    
    private static let colourMap: [ThemeColour: Color] = [
        .blue: .blue,
        .orange: .orange,
        .green: .green,
        .red: .red,
        .yellow: .yellow,
        .purple: .purple
    ]
    
    private static let themes = [
        Theme(name: "Modes of transport", distinctCardContents: ["✈️", "🚃", "🚗", "⛴", "🚛", "🚚", "🚙", "🚕", "🚓", "🏍", "🚲", "🛳", "🚢", "🚤", "⛵️", "🛶"], pairsToShow: 6, colour: ThemeColour.blue),
        Theme(name: "Animals", distinctCardContents: ["🐱", "🐶", "🐭", "🐷", "🐹", "🐠", "🐻", "🦊", "🐌", "🐮", "🐴", "🦋", "🐝", "🐀", "🦜", "🐗"], pairsToShow: 10, colour: ThemeColour.orange),
        Theme(name: "Flags", distinctCardContents: ["🇬🇧", "🇬🇭", "🇿🇦", "🇹🇭", "🇫🇷", "🇵🇫", "🇸🇦"], pairsToShow: 4, colour: ThemeColour.purple),
        Theme(name: "Expressions", distinctCardContents: ["🙂", "😬", "😎", "😂", "😆", "🤪", "😫", "😡"], pairsToShow: 5, colour: ThemeColour.yellow),
        Theme(name: "Olympic sports", distinctCardContents: ["⚽️", "🏉", "⛷", "🥌", "🏊", "🏹", "🥊"], pairsToShow: 7, colour: ThemeColour.green),
        Theme(name: "Murder weapons", distinctCardContents: ["🔪", "💣", "🔫", "💪", "🧪", "🔥"], pairsToShow: 6, colour: ThemeColour.red)
        ]
    
    @Published private var model: MemoryGame<String> = MemoryGame<String>(themes.randomElement()!)
    
    
    func newGame() {
        self.model = MemoryGame<String>(EmojiMemoryGame.themes.randomElement()!)
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var cardColour: Color {
        EmojiMemoryGame.colourMap[model.theme.colour]!
    }
    
    var themeName: String {
        model.theme.name
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
