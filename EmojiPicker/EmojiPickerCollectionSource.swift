//
//  EmojiPickerCollectionSource.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerCollectionSource: NSObject, NSCollectionViewDataSource {
    private let emojiCollection : [EmojiSection] // TODO: think about how I can make this only populate once (and if it would be worth it)
    
    override init() {
        if let emojiURL = Bundle.main.url(forResource: "emoji", withExtension: "json"),
           let data = try? String(contentsOf: emojiURL).data(using: .utf8),
           let emojiCollection = try? JSONDecoder().decode([EmojiSection].self, from: data) {
            self.emojiCollection = emojiCollection
        }
        else {
            self.emojiCollection = [EmojiSection]()
        }
        
        super.init()
    }
    
    func emoji(at index: IndexPath) -> String? {
        emojiCollection[index.section].emojis[index.item].emoji
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        emojiCollection.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        emojiCollection[section].emojis.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let emojiItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("EmojiCollectionViewItem"), for: indexPath)
        
        if let field = emojiItem.textField, let emoji = emoji(at: indexPath) {
            field.stringValue = emoji
        }
        return emojiItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        //        if kind == NSCollectionView.elementKindSectionHeader {
        let sectionHeader = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: EmojiCollectionViewSectionHeaderView.identifier, for: indexPath)
        
        if let emojiSectionHeader = sectionHeader as? EmojiCollectionViewSectionHeaderView {
            
            emojiSectionHeader.name.stringValue = emojiCollection[indexPath.section].title
            
            return emojiSectionHeader
        }
        
        return sectionHeader
        //        }
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
