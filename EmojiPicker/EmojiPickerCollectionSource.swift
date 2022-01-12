//
//  EmojiPickerCollectionSource.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerCollectionSource: NSObject, NSCollectionViewDataSource {
    private let emojiCollection : [String] // TODO: think about how I can make this only populate once (and if it would be worth it)
    
    override init() {
        // inspired by https://stackoverflow.com/a/53388482
        // and https://stackoverflow.com/a/26171421
        // fill the list with emoticons
        var collection = [String]()
        collection.reserveCapacity(0x1F64F-0x1F600+1)
        for i in 0x1F600...0x1F64F {
            guard let scalar = UnicodeScalar(i) else { continue }
            let emoticon = String(scalar)
            collection.append(emoticon)
        }
        print("number of emoji in available to picker: \(collection.count)")
        print("capacity of array: \(collection.capacity)")
        self.emojiCollection = collection
        
        super.init()
    }
    
    func emoji(at index: IndexPath) -> String? {
        guard index.section == 0 else {
            return nil
        }
        return emojiCollection[index.item]
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        1 // update this when supporting multiple sections of emojis; i.e. smileys, flags, etc
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        emojiCollection.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("EmojiCollectionViewItem"), for: indexPath)
        
        if let emojiItem = item as? EmojiCollectionViewItem {
            
        if let field = emojiItem.textField, let emoji = emoji(at: indexPath) {
            emojiItem.button?.title = emoji
            emojiItem.button?.action = 
//            field.stringValue = emoji
        }
        return emojiItem
        }
        return item
    }
}
