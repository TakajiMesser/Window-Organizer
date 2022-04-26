//
//  Units.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/20/21.
//

import Foundation

enum UnitType {
    case Pixel
    case Percent
}

struct Units: Equatable {
    let value: CGFloat;
    let type: UnitType
    
    init(_ value: CGFloat, _ type: UnitType) {
        self.value = value
        self.type = type
    }
    
    func toPixels(_ availableValue: CGFloat) -> CGFloat {
        if (type == UnitType.Pixel) {
            return value
        }
        else if (type == UnitType.Percent) {
            return availableValue / 100.0 * value
        }
        
        fatalError("Unhandled unit type")
    }
    
    static func ==(lhs: Units, rhs: Units) -> Bool {
        return lhs.value == rhs.value && lhs.type == rhs.type
    }
}
