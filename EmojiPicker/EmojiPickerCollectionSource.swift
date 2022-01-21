//
//  EmojiPickerCollectionSource.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerCollectionSource: NSObject, NSCollectionViewDataSource {
    
    var searchResults = [Emoji]()
    
    var searchString : String
    {
        didSet {
            searchResults = EmojiManager.sharedInstance.emoji(matching: searchString)
        }
    }
    
    override init() {
        searchString = "eyes"
        searchResults = EmojiManager.sharedInstance.emoji(matching: searchString)
    }
    
    func emoji(at index: IndexPath) -> String? {
        // Section 0 is a pseudo-section to show search results
        if index.section == 0 {
            return searchResults[index.item].emoji
        }
        else {
            return EmojiManager.sharedInstance.emojiCollection[index.section - 1].emojis[index.item].emoji
        }
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        EmojiManager.sharedInstance.emojiCollection.count + 1 // 1 for search section
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section 0 is a pseudo-section to show search results
        if section == 0 {
            return searchResults.count
        }
        else {
            return EmojiManager.sharedInstance.emojiCollection[section - 1].emojis.count
        }
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
            
            if indexPath.section == 0 {
                emojiSectionHeader.name.stringValue = "Search Results"
            } else {
                emojiSectionHeader.name.stringValue = EmojiManager.sharedInstance.emojiCollection[indexPath.section - 1].title
            }
            
            return emojiSectionHeader
        }
        
        return sectionHeader
        //        }
    }
}
