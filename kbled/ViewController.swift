//
//  ViewController.swift
//  kbled
//
//  Created by admin on 22/01/20.
//  Copyright © 2020 FreeAppSW. All rights reserved.
//

import Cocoa

var loop: Bool = false;

class ViewController: NSViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // check led status
        if (manipulate_led(2) == 1) {
            needsToBeShutDown = false;
            self.capsBtn!.state = 1;
        }
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBOutlet weak var capsBtn: NSButton!
    @IBAction func press(_ sender: NSButton) {
        manipulate_led(UInt32(self.capsBtn!.state));
    }
    @IBOutlet weak var IntervalTF: NSTextField!
    @IBOutlet weak var StartBtn: NSButton!
    @IBOutlet weak var StopBtn: NSButton!
    @IBOutlet weak var power: NSTextField!
    @IBAction func StartProgram(_ sender: AnyObject) {
        loop = true;
        guard let i = Int(self.IntervalTF.stringValue) else {
            let alert: NSAlert = NSAlert();
            alert.alertStyle = NSAlertStyle.critical;
            alert.messageText = "Please enter a valid integer";
            alert.runModal();
            return;

        };
        self.capsBtn.isEnabled = false;
        self.StopBtn.isEnabled = true;
        self.StartBtn.isEnabled = false;
        let queue = DispatchQueue.global(qos: .userInitiated);
        queue.async(execute: {
            while (loop) {
                manipulate_led(1);
                DispatchQueue.main.sync(execute: {self.power.isHidden = false;});
                usleep(UInt32(i * 1000));
                manipulate_led(0);
                DispatchQueue.main.sync(execute: {self.power.isHidden = true;});
                usleep(UInt32(i * 1000));
            }

        })

    }
   
    @IBAction func StopProgra(_ sender: AnyObject) {
        self.StopBtn.isEnabled = false;
        self.StartBtn.isEnabled = true;
        loop = false;
        self.capsBtn.isEnabled = true;
        self.power.isHidden = true;
    }
}

