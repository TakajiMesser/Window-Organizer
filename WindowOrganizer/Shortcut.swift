//
//  Shortcut.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/7/21.
//

import AppKit
import Cocoa

class Shortcut {
    let name: String
    let key: UInt16
    let modifiers: NSEvent.ModifierFlags
    let handler: () -> Void
    
    init(_ name: String, _ key: UInt16, _ modifiers: NSEvent.ModifierFlags, _ handler: @escaping () -> Void) {
        self.name = name
        self.key = key
        self.modifiers = modifiers
        self.handler = handler
    }
    
    func onKeyDown(_ keyCode: UInt16, _ modifierFlags: NSEvent.ModifierFlags) {
        if isTriggered(keyCode, modifierFlags) {
            handler()
        }
    }
    
    func isTriggered(_ keyCode: UInt16, _ modifierFlags: NSEvent.ModifierFlags) -> Bool {
        return key == keyCode && modifierFlags.intersection(.deviceIndependentFlagsMask) == modifiers
    }
}
