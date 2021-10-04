//
//  MemoryGame.swift
//  Memorise
//
//  Created by Philip Rose on 9/24/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    let theme: Theme
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(_ theme: Theme) {
        self.theme = theme
        
        cards = [Card]()
        
        let cardContents = theme.distinctCardContents.shuffled()
        
        for pairIndex in 0..<min(theme.pairsToShow, cardContents.count) {
            let content = cardContents[pairIndex]
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pairIndex * 2))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score += 2
                } else {
                    score -= 1
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
    }
    
    struct Theme {
        let name: String
        let distinctCardContents: [CardContent]
        let pairsToShow: Int
        let colour: ThemeColour
    }
    
    enum ThemeColour {
        case red, blue, green, yellow, purple, orange
    }
}
