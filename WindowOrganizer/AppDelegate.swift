//
//  AppDelegate.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/1/21.
//

import AppKit
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString : true]
        if AXIsProcessTrustedWithOptions(options) {
            ShortcutManager.sharedInstance.registerGlobalKeyMonitor()
        }
        else {
            print("Access Not Enabled")
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
}

/*extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        //dateTimeView?.startTimer()
    }
    
    
    func menuDidClose(_ menu: NSMenu) {
        //dateTimeView?.stopTimer()
    }
}*/
