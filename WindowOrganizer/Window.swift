//
//  Window.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 3/29/21.
//

import Foundation
import CoreGraphics

class Window {
    var name: String
    var pid: Int32?
    var position: CGPoint
    var size: CGSize
    
    init(_ dictionary: [String : AnyObject]) {
        name = dictionary[kCGWindowOwnerName as String] as! String
        pid = dictionary[kCGWindowOwnerPID as String] as? Int32
        position = CGPoint(x: 0, y: 0)
        size = CGSize(width: 0, height: 0)
        //var bounds = dictionary[kCGWindowBounds as String] as? [String: Int]
        
        let appRef = AXUIElementCreateApplication(pid!);  //TopLevel Accessability Object of PID

        var value: AnyObject?
        let result = AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)
        
        if let windows = value as? [AXUIElement] {
            //print ("windows #\(windows)")
            
            for window in windows {
                var positionType: CFTypeRef?
                AXUIElementCopyAttributeValue(window, kAXPositionAttribute as CFString, &positionType)
                AXValueGetValue(positionType as! AXValue, AXValueType(rawValue: kAXValueCGPointType)!, &position)
                
                var sizeType: CFTypeRef?
                AXUIElementCopyAttributeValue(window, kAXSizeAttribute as CFString, &sizeType)
                AXValueGetValue(sizeType as! AXValue, AXValueType(rawValue: kAXValueCGSizeType)!, &size)
                
                print("owner = %s", name)
                //print("position = <%f, %f>", position.x, position.y)
                //print("size = <%f, %f>", size.width, size.height)
            }
        }
    }
    
    func move(_ newPosition: CGPoint) {
        let appRef = AXUIElementCreateApplication(pid!);  //TopLevel Accessability Object of PID

        var value: AnyObject?
        let result = AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)
        
        if let windows = value as? [AXUIElement] {
            for window in windows {
                var positionType : CFTypeRef
                var position = CGPoint(x: newPosition.x, y: newPosition.y)
                
                positionType = AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!, &position)!;
                AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, positionType);
            }
        }
    }
    
    func resize(_ newSize: CGSize) {
        let appRef = AXUIElementCreateApplication(pid!);  //TopLevel Accessability Object of PID

        var value: AnyObject?
        let result = AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)
        
        if let windows = value as? [AXUIElement] {
            for window in windows {
                var sizeType : CFTypeRef
                var size = CGSize(width: newSize.width, height: newSize.height)
                
                sizeType = AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!, &size)!;
                AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, sizeType);
            }
        }
    }
}

/*let type = CGWindowListOption.optionOnScreenOnly
let windowList = CGWindowListCopyWindowInfo(type, kCGNullWindowID) as NSArray? as? [[String: AnyObject]]

for entry  in windowList!
{
  let owner = entry[kCGWindowOwnerName as String] as! String
  var bounds = entry[kCGWindowBounds as String] as? [String: Int]
  let pid = entry[kCGWindowOwnerPID as String] as? Int32

  if owner == "Terminal"
  {
    let appRef = AXUIElementCreateApplication(pid!);  //TopLevel Accessability Object of PID

    var value: AnyObject?
    let result = AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)

    if let windowList = value as? [AXUIElement]
    { print ("windowList #\(windowList)")
      if let window = windowList.first
      {
        var position : CFTypeRef
        var size : CFTypeRef
        var newPoint = CGPoint(x: 0, y: 0)
        var newSize = CGSize(width: 800, height: 800)

        position = AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!,&newPoint)!;
        AXUIElementSetAttributeValue(windowList.first!, kAXPositionAttribute as CFString, position);

        size = AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!,&newSize)!;
        AXUIElementSetAttributeValue(windowList.first!, kAXSizeAttribute as CFString, size);
      }
    }
  }
}*/
