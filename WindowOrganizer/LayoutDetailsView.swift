//
//  LayoutDetailsView.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 5/4/21.
//

import Cocoa
import Foundation

class LayoutDetailsView : NSView {
    /*private var x: Units = Units(0.0, UnitType.Pixel)
     private var y: Units = Units(0.0, UnitType.Pixel)
     
     private var width: Units = Units(100.0, UnitType.Percent)
     private var height: Units = Units(100.0, UnitType.Percent)
     
     private var horizontalAnchor = Anchor.Start
     private var verticalAnchor = Anchor.Start*/
    
    @IBOutlet weak var xText: NSTextField!
    @IBOutlet weak var yText: NSTextField!
    @IBOutlet weak var widthText: NSTextField!
    @IBOutlet weak var heightText: NSTextField!
    
    @IBOutlet weak var xUnitDropdown: NSPopUpButton!
    @IBOutlet weak var yUnitDropdown: NSPopUpButton!
    @IBOutlet weak var widthUnitDropdown: NSPopUpButton!
    @IBOutlet weak var heightUnitDropdown: NSPopUpButton!
    
    @IBOutlet weak var horizontalAnchorDropdown: NSPopUpButton!
    @IBOutlet weak var verticalAnchorDropdown: NSPopUpButton!
    
    private var layout: Layout?
    
    init() {
        super.init(frame: NSRect.zero)
        let xib = ViewUtils.loadNIB(owner: self, name:"LayoutDetailsView")
        
        if let view = xib {
            ViewUtils.addView(fromView: view, toView: self)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLayout(layout: Layout) {
        self.layout = layout
        
        // TODO - Update UI
        xText.stringValue = convertToValueString(units: layout.x)
        yText.stringValue = convertToValueString(units: layout.y)
        widthText.stringValue = convertToValueString(units: layout.width)
        heightText.stringValue = convertToValueString(units: layout.height)
        
        xUnitDropdown.stringValue = convertToTypeString(units: layout.x);
        yUnitDropdown.stringValue = convertToTypeString(units: layout.y);
        widthUnitDropdown.stringValue = convertToTypeString(units: layout.width);
        heightUnitDropdown.stringValue = convertToTypeString(units: layout.height);
        
        horizontalAnchorDropdown.stringValue = convertToTypeString(anchor: layout.horizontalAnchor);
        verticalAnchorDropdown.stringValue = convertToTypeString(anchor: layout.verticalAnchor);
    }
    
    private func convertToValueString(units: Units) -> String {
        let formatter = NumberFormatter()
        
        if (units.type == .Pixel) {
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
        }
        else {
            formatter.numberStyle = .percent
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
        }
        
        let number = units.value * 0.01 as NSNumber
        return formatter.string(from: number)!
    }
    
    private func convertToTypeString(units: Units) -> String {
        switch (units.type) {
            case .Pixel:
                return "Pixels";
            case .Percent:
                return "Percents";
        }
    }
    
    private func convertToTypeString(anchor: Anchor) -> String {
        switch (anchor) {
            case .Start:
                return "Start";
            case .Center:
                return "Center";
            case .End:
                return "End";
        }
    }
}
