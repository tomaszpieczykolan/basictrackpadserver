//
//  AppDelegate.swift
//  Basic Trackpad Server
//
//  Created by Tomasz Pieczykolan on 11/12/16.
//  Copyright © 2016 Tomasz Pieczykolan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        ConnectionManager.shared // waking up manager
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

