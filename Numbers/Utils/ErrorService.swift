//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import UIKit

class ErrorService {

    class func handleError(error: NSError, withHandler: ((UIAlertAction) -> Void)?, onViewController:UIViewController) {
        
        // TODO : adjust error message for specific error based on type if needed
        
        let alertController = UIAlertController(title: "Error", message:
            "Connection error", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default,handler: withHandler))
    
        dispatch_async(dispatch_get_main_queue()) {
                onViewController.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
}
