//
//  Card.swift
//  FlashZilla
//
//  Created by Sarvad shetty on 2/19/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played 13th doctor in Dr.Who?", answer: "Jodie Whittaker")
    }
}
