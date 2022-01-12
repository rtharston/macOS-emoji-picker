//
//  EmojiPickerViewController.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class EmojiPickerViewController: NSViewController {
    
    @IBOutlet weak var emojiCollectionView: NSCollectionView!
    
    let emojiSource = EmojiPickerCollectionSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        emojiCollectionView.dataSource = emojiSource
    }
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
                
                // do something with the selected emoji to append it to the text box in the other window
            }
        }
    }
}
