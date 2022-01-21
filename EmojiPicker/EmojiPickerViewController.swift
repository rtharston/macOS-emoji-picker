//
//  EmojiPickerViewController.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerViewController: NSViewController {
    
    @IBOutlet weak var emojiCollectionView: NSCollectionView!
    {
        didSet {
            emojiCollectionView.dataSource = emojiSource
        }
    }
    
    var textToAppendTo : NSText?
    
    let emojiSource = EmojiPickerCollectionSource()
}

extension EmojiPickerViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if collectionView == emojiCollectionView {
            // Can't select more than one emoji
            guard indexPaths.count == 1, let indexPath = indexPaths.first else {
                return
            }
            
            if let selectedEmoji = collectionView.item(at: indexPath)?.textField?.stringValue {
                print("User selected: \(selectedEmoji)")
                
                textToAppendTo?.insertText(selectedEmoji)
                collectionView.deselectItems(at: indexPaths)
            }
        }
    }
}

extension EmojiPickerViewController : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
    NSSize(width: 0, height: 24)
  }
}
