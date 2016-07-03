//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import UIKit

class NumberTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numbersImageView: UIImageView!
    
    func configureWithNumber(number: Number) {
        nameLabel.text = number.name
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: number.imageUrl)!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if error == nil && data != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.numbersImageView.image = UIImage(data: data!)
                }
            }
        }.resume()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        backgroundColor = selected ? UIColor.redColor() : UIColor.clearColor()
        nameLabel.textColor = selected ? UIColor.whiteColor() : UIColor.blackColor()
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? UIColor.blueColor() : UIColor.clearColor()
        nameLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
    }
}
