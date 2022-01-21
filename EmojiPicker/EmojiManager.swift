//
//  EmojiManager.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/19/22.
//

import Foundation

class EmojiManager {
    static let sharedInstance = EmojiManager()
    static let searchEmojiIcon = "🔍"
    
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
    
    func emoji(matching: String) -> EmojiSection {
        var results = [Emoji]()
        
        for section in emojiCollection {
            for e in section.emojis {
                if e.name.contains(matching) {
                    results.append(e)
                }
            }
        }
        
        return EmojiSection(title: "Search Results", representativeEmoji: EmojiManager.searchEmojiIcon, emojis: results)
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
