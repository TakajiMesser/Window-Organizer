//
//  LayoutOutlineController.swift
//  WindowOrganizer
//
//  Created by Takaji Messer on 4/21/21.
//

import Foundation
import Cocoa
import AppKit

class LayoutOutlineController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    @IBOutlet weak var detailViewContainer: NSView!
    
    lazy var layoutDetailsView: LayoutDetailsView = {
        let view = LayoutDetailsView()
        //let view = ViewUtils.loadNIB(owner: self, name: "LayoutDetailsView") as! LayoutDetailsView
        view.isHidden = true
        ViewUtils.addView(fromView: view, toView: detailViewContainer)
        
        return view
    }()
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return LayoutManager.sharedInstance.count
        }
        else if let arrangement = item as? Arrangement {
            return arrangement.layouts.count
        }
        else {
            return 1
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return LayoutManager.sharedInstance.arrangementAt(index)
        }
        else if let arrangement = item as? Arrangement {
            return arrangement.layouts[index]
        }
        else {
            return item!
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let _ = item as? Arrangement {
            return true
        }
        else {
            return false
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "ArrangementColumn") {
            let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ArrangementCell"), owner: self) as? NSTableCellView
            
            if let cell = view {
                if let arrangement = item as? Arrangement {
                    cell.textField?.stringValue = arrangement.name
                    cell.textField?.isEditable = true
                    //cell.textField?.delegate = self
                }
                else if let layout = item as? Layout {
                    cell.textField?.stringValue = "Layout"
                    cell.textField?.isEditable = false
                }
                
                return cell
            }
        }
        else {
            let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LayoutsCell"), owner: self) as? NSTableCellView
            
            if let cell = view {
                if let arrangement = item as? Arrangement {
                    cell.textField?.stringValue = String(arrangement.layouts.count)
                }
                else if let layout = item as? Layout {
                    cell.textField?.stringValue = "?"
                }
                
                return cell
            }
        }
        
        return nil
        
        /*guard let colIdentifier = tableColumn?.identifier else { return nil }
        if colIdentifier == NSUserInterfaceItemIdentifier(rawValue: "col1") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "cell1")
            guard let cell = outlineView.makeView(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView else { return nil }
            
            if let collection = item as? Collection {
                cell.textField?.stringValue = collection.title ?? ""
                cell.textField?.isEditable = true
                cell.textField?.delegate = self
                cell.textField?.layer?.backgroundColor = NSColor.clear.cgColor
            } else if let color = item as? Color {
                cell.textField?.stringValue = ""
                cell.textField?.isEditable = false
                cell.textField?.wantsLayer = true
                cell.textField?.layer?.backgroundColor = color.toNSColor().cgColor
                cell.textField?.layer?.cornerRadius = 5.0
            
            }
            
            return cell
            
        } else {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "cell2")
            guard let cell = outlineView.makeView(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView else { return nil }
            
            if let collection = item as? Collection {
                cell.textField?.stringValue = collection.totalItems != 1 ? "\(collection.totalItems) items" : "1 item"
                cell.textField?.font = NSFont.boldSystemFont(ofSize: cell.textField?.font?.pointSize ?? 13.0)
            } else if let color = item as? Color {
                cell.textField?.stringValue = color.description
                cell.textField?.font = NSFont.systemFont(ofSize: cell.textField?.font?.pointSize ?? 13.0)
            }
            
            return cell
        }*/
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        if let outlineView = notification.object as? NSOutlineView {
            let selectedIndex = outlineView.selectedRow
            
            if let arrangement = outlineView.item(atRow: selectedIndex) as? Arrangement {
                //arrangementDetailsView.set(arrangement: arrangement)
                //arrangement.show()
                layoutDetailsView.isHidden = true
            }
            else if let layout = outlineView.item(atRow: selectedIndex) as? Layout {
                layoutDetailsView.setLayout(layout: layout)
                layoutDetailsView.isHidden = false
            }
            else {
                //arrangementDetailsView.hide()
                layoutDetailsView.isHidden = true
            }
        }
    }
}
