//
//  Deck.swift
//  Kade-Capstone
//
//  Created by 11k on 1/23/23.
//

import Foundation

struct Deck {
    static var terms:[String:String] = [:]
    static var keys: [String] {
            return Array(terms.keys)
    }
}
