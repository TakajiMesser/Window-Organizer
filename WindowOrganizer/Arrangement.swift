//
//  Arrangement.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 3/31/21.
//

import AppKit
import Cocoa
import Foundation

class Arrangement {
    var name: String
    var layouts = [Layout]()
    
    init(_ name: String) {
        self.name = name
        
        let leftLayout = Layout("Left Half")
        leftLayout.setAnchors(Anchor.Start, Anchor.Start)
        leftLayout.setDimensions(Units(50.0, UnitType.Percent), Units(100.0, UnitType.Percent))
        leftLayout.windowNames.append("Google Chrome")
        leftLayout.windowNames.append("GitHub Desktop")
        leftLayout.windowNames.append("Android Studio")
        leftLayout.windowNames.append("Xcode")
        leftLayout.windowNames.append("Qt Creator")
        
        let rightLayout = Layout("Right Half")
        rightLayout.setAnchors(Anchor.End, Anchor.Start)
        rightLayout.setDimensions(Units(50.0, UnitType.Percent), Units(100.0, UnitType.Percent))
        rightLayout.windowNames.append("Visual Studio Code")
        rightLayout.windowNames.append("Finder")
        rightLayout.windowNames.append("Slack")
        
        layouts.append(leftLayout)
        layouts.append(rightLayout)
    }
    
    func apply() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)

        if !accessEnabled {
            print("Access Not Enabled")
        }
        
        let screenSize = NSScreen.main!.visibleFrame.size
        let windowByName = getWindowsByName()

        for layout in layouts {
            for windowName in layout.windowNames {
                let window = windowByName[windowName]
                
                if (window != nil) {
                    layout.apply(window!, screenSize)
                }
            }
        }
    }
    
    private func getWindowsByName() -> [String: Window] {
        let windowInfoList = CGWindowListCopyWindowInfo(CGWindowListOption.optionOnScreenOnly, kCGNullWindowID) as NSArray? as? [[String: AnyObject]]
        var windowByName = [String: Window]()
        
        for windowInfo in windowInfoList! {
            let window = Window(windowInfo)
            windowByName[window.name] = window
        }
        
        return windowByName
    }
}
