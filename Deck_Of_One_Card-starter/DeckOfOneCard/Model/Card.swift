//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Emily Asch on 2/22/22.
//  Copyright © 2022 Warren. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable{
    var cards: [Card]
}

struct Card: Decodable{
    var value: String
    var suit: String
    var image: URL
}
