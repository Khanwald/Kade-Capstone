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
    
    static var defs:[String]{
        var a:[String] = []
        for term in keys{
            if let key = terms[term]{
                a.append(key)
            }
        }
        
        return a
    }
    static var c:[String]{
        return defs + keys
    }
    static var combined:[String]{
        return c.shuffled()
    }
}
