//
//  ViewController.swift
//  ProgressButton
//
//  Created by WJ on 16/2/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: WJProgressButton!
    
    var timer:NSTimer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "fireTimer:", userInfo: nil, repeats: true)
        timer!.fireDate = NSDate.distantFuture()
        
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.grayColor().CGColor
        
        button.layer.backgroundColor = UIColor.yellowColor().CGColor
        button.progressBackgroundColor = UIColor.cyanColor()
        button.progressFontColor = UIColor.redColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fireTimer(timer:NSTimer){
        button.enabled = true
        timer.fireDate = NSDate.distantFuture()
        print("enable")
        
    }


    @IBAction func clickToDisable(sender: WJProgressButton) {
        button.enabled = false
        timer!.fireDate = NSDate(timeIntervalSinceNow: 3)
        print("disable")
    }

    @IBAction func step(sender: UIStepper) {
        button.progress = CGFloat(sender.value)
    }

}

