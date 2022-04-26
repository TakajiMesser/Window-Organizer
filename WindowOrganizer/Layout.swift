//
//  Layout.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 3/31/21.
//

import Foundation

class Layout: Equatable {
    var name: String
    var windowNames = [String]()
    
    var x: Units = Units(0.0, UnitType.Pixel)
    var y: Units = Units(0.0, UnitType.Pixel)
    
    var width: Units = Units(100.0, UnitType.Percent)
    var height: Units = Units(100.0, UnitType.Percent)
    
    var horizontalAnchor = Anchor.Start
    var verticalAnchor = Anchor.Start
    
    init(_ name: String) {
        self.name = name
    }
    
    func setOffset(_ x: Units, _ y: Units) {
        self.x = x
        self.y = y
    }
    
    func setDimensions(_ width: Units, _ height: Units) {
        self.width = width
        self.height = height
    }
    
    func setAnchors(_ horizontalAnchor: Anchor, _ verticalAnchor: Anchor) {
        self.horizontalAnchor = horizontalAnchor
        self.verticalAnchor = verticalAnchor
    }
    
    func apply(_ window: Window, _ availableSize: CGSize) {
        let size = measure(availableSize)
        let position = locate(availableSize, size)
        
        window.move(position)
        window.resize(size)
    }
    
    private func measure(_ availableSize: CGSize) -> CGSize {
        let widthPixels = width.toPixels(availableSize.width)
        let heightPixels = height.toPixels(availableSize.height)
        
        return CGSize(width: widthPixels, height: heightPixels)
    }
    
    private func locate(_ availableSize: CGSize, _ measuredSize: CGSize) -> CGPoint {
        let xOffset = x.toPixels(availableSize.width)
        let yOffset = y.toPixels(availableSize.height)
        
        var position = CGPoint(x: xOffset, y: yOffset)
        
        if (horizontalAnchor == Anchor.Center) {
            position.x += (availableSize.width - measuredSize.width) / 2.0
        }
        else if (horizontalAnchor == Anchor.End) {
            position.x += availableSize.width - measuredSize.width
        }
        
        if (verticalAnchor == Anchor.Center) {
            position.y += (availableSize.height - measuredSize.height) / 2.0
        }
        else if (verticalAnchor == Anchor.End) {
            position.y += availableSize.height - measuredSize.height
        }
        
        return position
    }
    
    static func ==(lhs: Layout, rhs: Layout) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.width == rhs.width
            && lhs.height == rhs.height
            && lhs.horizontalAnchor == rhs.horizontalAnchor
            && lhs.verticalAnchor == rhs.verticalAnchor
    }
}
