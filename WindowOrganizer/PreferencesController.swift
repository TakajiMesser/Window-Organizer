//
//  PreferencesController.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/5/21.
//

import Foundation
import Cocoa
import AppKit

class PreferencesController: NSWindowController {
    @IBOutlet weak var preferencesWindow: NSWindow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func showPreferencesWindow(_ sender: NSMenuItem) {
        preferencesWindow.makeKeyAndOrderFront(nil)
        
        /*let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: .init(stringLiteral: "preferencesID")) as? ViewController else { return }
        
        let window = NSWindow(contentViewController: vc)
        window.makeKeyAndOrderFront(nil)*/
    }

    @IBAction func addLayout(_ sender: NSButton) {
        
    }
}
