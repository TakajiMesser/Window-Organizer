//
//  LayoutManager.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/21/21.
//

import Foundation

class LayoutManager {
    static let sharedInstance = LayoutManager()
    
    var arrangements = [Arrangement]()
    var arrangementByName = [String: Arrangement]()
    
    init() {
        add(Arrangement("Main"))
    }
    
    var count: Int {
        arrangements.count
    }
    
    func arrangementAt(_ index: Int) -> Arrangement {
        return arrangements[index]
    }
    
    func add(_ arrangement: Arrangement) {
        arrangements.append(arrangement)
        arrangementByName[arrangement.name] = arrangement
    }
    
    func layoutFor(_ name: String) -> Arrangement? {
        return arrangementByName[name]
    }
}
