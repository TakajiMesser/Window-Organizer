//
//  StatusMenu.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/7/21.
//

import Cocoa

class StatusMenuController : NSObject {
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var enabledMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var isEnabled = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        statusItem.button?.title = "Window Organizer"
        statusItem.menu = menu

        enabledMenuItem.state = NSControl.StateValue.on
        isEnabled = true

        //menu.delegate = self
        
        /*statusItem.menu = statusMenu
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        weatherMenuItem = statusMenu.item(withTitle: "Weather")
        weatherMenuItem.view = weatherView
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self*/
    }
    
    @IBAction func performLayout(_ sender: NSMenuItem) {
        LayoutManager.sharedInstance.layoutFor("Main")!.apply()
    }
    
    @IBAction func toggleEnabled(_ sender: NSMenuItem) {
        if isEnabled {
            ShortcutManager.sharedInstance.unregisterGlobalKeyMonitor()
            enabledMenuItem.state = NSControl.StateValue.off
            isEnabled = false
        }
        else {
            ShortcutManager.sharedInstance.registerGlobalKeyMonitor()
            enabledMenuItem.state = NSControl.StateValue.on
            isEnabled = true
        }
    }
}
