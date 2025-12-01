//
//  MainView.swift
//  ScreenGameCapture
//
//  Created by Ronaldo Albertini on 08/10/25.
//

import Cocoa

class MainView: NSView {

    @IBOutlet var teste: NSButton!
    @IBOutlet var contentView: NSView!

    @IBAction func testeAction(_ sender: Any) {
        
        // Cria uma janela de seleção
        let selectionWindow = SelectionWindow()
        selectionWindow.onSelectionComplete = { rect in
            self.capture(rect: rect)
        }
        selectionWindow.makeKeyAndOrderFront(nil)
    }
    
    func captureSelectedRegion() {
        // Cria uma janela de seleção
        let selectionWindow = SelectionWindow()
        selectionWindow.onSelectionComplete = { rect in
            self.capture(rect: rect)
        }
        selectionWindow.makeKeyAndOrderFront(nil)
    }

    private func capture(rect: CGRect) {
        guard let image = CGWindowListCreateImage(rect, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution) else {
            print("Falha ao capturar imagem.")
            return
        }
        
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let fileURL = desktopURL.appendingPathComponent("captura.png")
        
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, kUTTypePNG, 1, nil) else {
            print("Falha ao criar destino da imagem.")
            return
        }
        
        CGImageDestinationAddImage(destination, image, nil)
        if CGImageDestinationFinalize(destination) {
            print("Imagem salva em: \(fileURL.path)")
        } else {
            print("Falha ao salvar imagem.")
        }
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


