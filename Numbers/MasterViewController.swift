//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MasterViewController.updateSizeClases), name: UIDeviceOrientationDidChangeNotification, object: nil)
        self.updateSizeClases()
    }

    func updateSizeClases() {
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
                let splitVC = self.childViewControllers[0] as! UISplitViewController
                self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Regular), forChildViewController: splitVC)
            } else if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
                let splitVC = self.childViewControllers[0] as! UISplitViewController
                self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Compact), forChildViewController: splitVC)
            }
        }
    }
}
