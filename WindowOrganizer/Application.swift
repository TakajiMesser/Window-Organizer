//
//  Application.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/5/21.
//

import Foundation
import AppKit
import Cocoa

class Application : NSView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func initNIB(view: NSView) -> NSView {
        let name = String(describing: type(of: view))
        let nib = NSNib(nibNamed: name, bundle: nil)
        
        var viewInstances: NSArray?
        viewInstances = NSArray()
        
        if nib!.instantiate(withOwner: view, topLevelObjects: &viewInstances) {
            let view = viewInstances?.firstObject
            
            if let unwrapped = view {
                return unwrapped as! NSView
            }
        }
        
        fatalError("NIB not found")
        //open func instantiate(withOwner owner: Any?, topLevelObjects: AutoreleasingUnsafeMutablePointer<NSArray?>?) -> Bool
    }
}
