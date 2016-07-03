//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import UIKit

class NumberDetailViewController: UIViewController {
    
    @IBOutlet weak var numbersImageView: UIImageView!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var numberName : String!
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NumberDetailViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        if numberName != nil {
             loadData()
        } else {
            goBack()
        }
    }
    
    func loadData() {
        TappticApiService.getNumberByName(numberName) { (number: Number?, error: NSError?) in
            if error == nil {
                if number != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.numberLabel.text = number?.name
                    }
                    if number?.imageUrl != nil {
                        self.loadImage(number!.imageUrl)
                    }
                }
            } else {
                ErrorService.handleError(error!, withHandler: { (UIAlertAction) in
                    self.loadData()
                    }, onViewController: self)
            }
        }
    }
    
    func loadImage(imageUrl: String) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: imageUrl)!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if error == nil &&  data != nil {
                if data != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.numbersImageView.image = UIImage(data: data!)
                    }
                }
            } else {
                ErrorService.handleError(error!, withHandler: { (UIAlertAction) in
                        self.loadImage(imageUrl)
                    }, onViewController: self)
            }}.resume()
    }
    
    func goBack() {
            if let controller = splitViewController!.viewControllers[0] as? UINavigationController {
                controller.popViewControllerAnimated(false)
            }
    }
    
    func rotated() {
         if ((DeviceType.IS_PAD || DeviceType.IS_IPHONE_6P) && UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
            self.goBack()
        }
    }

}
