//
//  MyCustomView.swift
//  testeleitortela
//
//  Created by Ronaldo Albertini on 30/09/25.
//


import Cocoa
import ScreenCaptureKit

class MyCustomView: NSView {

    @IBOutlet var teste: NSButton!
    @IBOutlet var contentView: NSView!

    @IBAction func testeAction(_ sender: Any) {
        
        let teste = SCContentSharingPicker.shared
        //teste.configuration?.allowedPickerModes = [.multipleApplications, .singleDisplay]
        teste.isActive = true
        teste.add(self)
        teste.present(using: .window)
        

        /*guard let screen = NSScreen.main else { return }

        let overlay = SelectionOverlay(screen: screen)
        overlay.onSelectionComplete = { [weak self] rect in
            //self?.screenCaptureManager.captureScreenArea(rect: rect)
            //let imageRef = CGWindowListCreateImage(rect, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution)
            debugPrint(rect.size)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              //  self?.textView.string = self?.screenCaptureManager.ocrResult.extractedText ?? ""
            }
        }
         */

    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Custom drawing code here
        NSColor.red.setFill()
        dirtyRect.fill()
    }

    override func mouseDown(with event: NSEvent) {
        print("Mouse clicked in MyCustomView!")
    }

    // Required initializer for Interface Builder
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // Initializer for programmatic creation
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
}

extension MyCustomView: SCContentSharingPickerObserver {
    func contentSharingPicker(_ picker: SCContentSharingPicker, didCancelFor stream: SCStream?) {
        debugPrint(picker, stream)
    }
    
    func contentSharingPicker(_ picker: SCContentSharingPicker, didUpdateWith filter: SCContentFilter, for stream: SCStream?) {
        debugPrint(picker, filter, stream)
    }
    
    func contentSharingPickerStartDidFailWithError(_ error: any Error) {
        
    }
}
