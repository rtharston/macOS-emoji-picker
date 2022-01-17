//
//  File.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/17/22.
//

import Cocoa

class EmojiCollectionViewSectionHeaderView: NSView, NSCollectionViewSectionHeaderView
{
    static let identifier = NSUserInterfaceItemIdentifier("EmojiCollectionViewSectionHeaderView")
    
    @IBOutlet weak var name: NSTextField!
}
