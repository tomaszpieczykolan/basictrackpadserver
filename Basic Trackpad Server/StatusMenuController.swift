//
//  StatusMenuController.swift
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBOutlet weak var statusView: StatusView!
    @IBOutlet weak var statusMenuItem: NSMenuItem!
    
    override func awakeFromNib() {
        statusItem.title = "Basic Trackpad"
        statusItem.menu = statusMenu
        
        statusMenuItem.view = statusView
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
}
