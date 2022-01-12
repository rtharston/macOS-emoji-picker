//
//  EmojiCollectionViewItem.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/12/22.
//

import Cocoa

class EmojiCollectionViewItem: NSCollectionViewItem {
    
    var button: NSButton?
    
    override func viewDidLoad() {
        button = NSButton()
        view.addSubview(button!)
    }
}
