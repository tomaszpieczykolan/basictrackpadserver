//
//  MouseManager.swift
//  Basic Trackpad Server
//
//  Created by Tomasz Pieczykolan on 13/12/16.
//  Copyright © 2016 Tomasz Pieczykolan. All rights reserved.
//

import Cocoa

class MouseManager {
    
    static let shared = MouseManager()
    
    private init() {
        
    }
    
    var mouseIsDown = false {
        didSet {
            let mouseLocation = self.mousePosition
            let event = CGEvent(mouseEventSource: nil, mouseType: self.mouseIsDown ? .leftMouseDown : .leftMouseUp, mouseCursorPosition: mouseLocation, mouseButton: .left)
            event?.post(tap: CGEventTapLocation.cghidEventTap)
        }
    }
    
    var mousePosition: CGPoint {
        set {
            let event = CGEvent(mouseEventSource: nil, mouseType: self.mouseIsDown ? .leftMouseDragged : .mouseMoved, mouseCursorPosition: newValue, mouseButton: .left)
            event?.post(tap: CGEventTapLocation.cghidEventTap)
        }
        get {
            let position = NSEvent.mouseLocation()
            return CGPoint(x: position.x, y: screenHeight - position.y)
        }
    }
    
    func translateMousePosition(by translation: CGVector) {
        let previousMouseLocation = self.mousePosition
        let newMouseLocation = CGPoint(x: previousMouseLocation.x + translation.dx, y: previousMouseLocation.y + translation.dy)
        self.mousePosition = newMouseLocation
    }
}
