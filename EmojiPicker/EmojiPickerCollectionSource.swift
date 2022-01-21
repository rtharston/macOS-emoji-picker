//
//  EmojiPickerCollectionSource.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerCollectionSource: NSObject, NSCollectionViewDataSource {
    
    var searchResults : EmojiSection
    
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
    
    func emojiSection(at sectionIndex: Int) -> EmojiSection? {
        guard sectionIndex >= 0 && sectionIndex <= EmojiManager.sharedInstance.emojiCollection.count else {
            return nil
        }
        
        // Section 0 is a pseudo-section to show search results
        if sectionIndex == 0 {
            return searchResults
        }
        else {
            return EmojiManager.sharedInstance.emojiCollection[sectionIndex - 1]
        }
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        EmojiManager.sharedInstance.emojiCollection.count + 1 // 1 for search section
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        emojiSection(at: section)?.emojis.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let emojiItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("EmojiCollectionViewItem"), for: indexPath)
        
        if let field = emojiItem.textField, let emojiSection = emojiSection(at: indexPath.section) {
            field.stringValue = emojiSection.emojis[indexPath.item].emoji
        }
        return emojiItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        //        if kind == NSCollectionView.elementKindSectionHeader {
        let sectionHeader = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: EmojiCollectionViewSectionHeaderView.identifier, for: indexPath)
        
        if let emojiSectionHeader = sectionHeader as? EmojiCollectionViewSectionHeaderView, let emojiSection = emojiSection(at: indexPath.section)  {
            
            emojiSectionHeader.name.stringValue = emojiSection.title
            
            return emojiSectionHeader
        }
        
        return sectionHeader
        //        }
    }
}
