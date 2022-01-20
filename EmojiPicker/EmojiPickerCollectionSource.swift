//
//  EmojiPickerCollectionSource.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerCollectionSource: NSObject, NSCollectionViewDataSource {
    
    func emoji(at index: IndexPath) -> String? {
        EmojiManager.sharedInstance.emojiCollection[index.section].emojis[index.item].emoji
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        EmojiManager.sharedInstance.emojiCollection.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        EmojiManager.sharedInstance.emojiCollection[section].emojis.count
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
            
            emojiSectionHeader.name.stringValue = EmojiManager.sharedInstance.emojiCollection[indexPath.section].title
            
            return emojiSectionHeader
        }
        
        return sectionHeader
        //        }
    }
}
