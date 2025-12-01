//
//  SelectionWindow.swift
//  ScreenGameCapture
//
//  Created by Ronaldo Albertini on 08/10/25.
//


//
//  SelectionWindow.swift
//  ScreenCapture
//
//  Created by Ronaldo Albertini on 08/10/25.
//  Copyright © 2025 nirix.net. All rights reserved.
//

import AppKit


class SelectionWindow: NSWindow {
    
    var onSelectionComplete: ((CGRect) -> Void)?
    private var startPoint: NSPoint?
    private var selectionLayer: CAShapeLayer?
    
    init() {
        let screenFrame = NSScreen.main?.frame ?? .zero
        super.init(contentRect: screenFrame, styleMask: .borderless, backing: .buffered, defer: false)
        
        self.level = .screenSaver
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.ignoresMouseEvents = false
        self.acceptsMouseMovedEvents = true
        
        let view = NSView(frame: screenFrame)
        self.contentView = view
        self.selectionLayer = CAShapeLayer()
        self.selectionLayer?.strokeColor = NSColor.red.cgColor
        self.selectionLayer?.lineWidth = 2
        self.selectionLayer?.fillColor = NSColor.clear.cgColor
        view.layer = CALayer()
        view.wantsLayer = true
        view.layer?.addSublayer(selectionLayer!)
    }
    
    override func mouseDown(with event: NSEvent) {
        startPoint = event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let start = startPoint else { return }
        let current = event.locationInWindow
        let rect = CGRect(x: min(start.x, current.x),
                          y: min(start.y, current.y),
                          width: abs(start.x - current.x),
                          height: abs(start.y - current.y))
        let path = CGPath(rect: rect, transform: nil)
        selectionLayer?.path = path
    }
    
    override func mouseUp(with event: NSEvent) {
        guard let start = startPoint else { return }
        let end = event.locationInWindow
        let rect = CGRect(x: min(start.x, end.x),
                          y: min(start.y, end.y),
                          width: abs(start.x - end.x),
                          height: abs(start.y - end.y))
        self.orderOut(nil)
        onSelectionComplete?(rect)
    }
}
