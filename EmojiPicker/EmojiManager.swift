//
//  EmojiManager.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/19/22.
//

import Foundation

class EmojiManager {
    static let sharedInstance = EmojiManager()
    
    let emojiCollection : [EmojiSection]
    
    private init() {
        if let emojiURL = Bundle.main.url(forResource: "emoji", withExtension: "json"),
           let data = try? String(contentsOf: emojiURL).data(using: .utf8),
           let emojiCollection = try? JSONDecoder().decode([EmojiSection].self, from: data) {
            self.emojiCollection = emojiCollection
        }
        else {
            self.emojiCollection = [EmojiSection]()
        }
    }
}

struct Emoji: Decodable {
    let name : String
    let emoji : String
}

struct EmojiSection: Decodable {
    let title : String
    let representativeEmoji : String
    let emojis : [Emoji]
}
