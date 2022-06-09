//
//  HeatControlApp.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 09.06.2022.
//

import SwiftUI

@main
struct HeatControlApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        SwiftSMC.shared.printSystemInformation()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "flame.circle", accessibilityDescription: "Heat control icon")
            statusButton.action = #selector(togglePopover)
            
            popover = NSPopover()
            popover.contentSize = NSSize(width: 300, height: 150)
            popover.behavior = .transient
            popover.contentViewController = NSHostingController(rootView: ContentView())
        }
    }
    
    @objc private func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
}
