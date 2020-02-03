//
//  AppDelegate.swift
//  kbled
//
//  Created by admin on 22/01/20.
//  Copyright © 2020 FreeAppSW. All rights reserved.
//

import Cocoa
var needsToBeShutDown: Bool = true;

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        //turn off LED after playing with it
        if (needsToBeShutDown) {manipulate_led(0);}
    }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool{
        return true;
    }


}

