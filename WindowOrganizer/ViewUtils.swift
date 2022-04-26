//
//  LayoutUtils.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/1/21.
//

import Cocoa
import CoreGraphics
import Foundation

class ViewUtils {
    static func loadNIB(owner: Any?, name: String) -> NSView? {
        //var nibObjects: NSArray?
        //let nibName = NSNib.Name(stringLiteral: name)
        
        /*if Bundle.main.loadNibNamed(nibName, owner: owner, topLevelObjects: &nibObjects) {
            //return nibObjects?.firstObject as! NSView
            
            guard let nibObjects = nibObjects else { return nil }
            
            let viewObjects = nibObjects.filter { $0 is NSView }
            
            if viewObjects.count > 0 {
                return viewObjects.first as? NSView
            }
        }*/
        
        /*var nibObjects: NSArray?
        let nibName = NSNib.Name(stringLiteral: name)
        
        if Bundle.main.loadNibNamed(nibName, owner: self, topLevelObjects: &nibObjects) {
            if let nibObjects = nibObjects {
                let viewObjects = nibObjects.filter { $0 is NSView }
                
                if viewObjects.count > 0 {
                    if let view = viewObjects[0] as? NSView {
                        owner.addSubview(view)
                        
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.leadingAnchor.constraint(equalTo: owner.leadingAnchor).isActive = true
                        view.trailingAnchor.constraint(equalTo: owner.trailingAnchor).isActive = true
                        view.topAnchor.constraint(equalTo: owner.topAnchor).isActive = true
                        view.bottomAnchor.constraint(equalTo: owner.bottomAnchor).isActive = true
                        
                        return view
                    }
                }
            }
        }*/
        
        var viewInstances: NSArray?
        let nib = NSNib(nibNamed: name, bundle: nil)
        
        if nib!.instantiate(withOwner: owner, topLevelObjects: &viewInstances) {
            if let views = viewInstances {
                for view in views {
                    if let castView = view as? NSView {
                        return castView
                    }
                }
            }
            
            
            //let view = viewInstances?.firstObject as! NSView
            //return view
        }
        
        return nil
    }

        
    static func addView(fromView childView: NSView, toView parentView: NSView) {
        parentView.addSubview(childView)
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        childView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    }
}
