//
//  ViewController.swift
//  EmojiPicker
//
//  Created by Reed Harston on 1/11/22.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var writingBox: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmojiPickerPopoverSeque" {
            if let emojiPickerViewController = segue.destinationController as? EmojiPickerViewController {
                emojiPickerViewController.textToAppendTo = writingBox
            }
        }
    }
}

