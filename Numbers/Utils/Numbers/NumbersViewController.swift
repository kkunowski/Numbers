//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import UIKit

class NumbersViewController: UITableViewController {
    
    var numbersArr : [Number] = []
    
    var selectedIndexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NumbersViewController.rotated), name: UIDeviceOrientationDidChangeNotification, object: nil)
        self.clearsSelectionOnViewWillAppear = false
        reloadNumbersData()
    }
    
    func reloadNumbersData() {
        TappticApiService.getNumbers { (numbers: [Number], error: NSError?) in
            if error != nil {
                ErrorService.handleError(error!, withHandler: { (UIAlertAction) in
                        self.reloadNumbersData()
                    }, onViewController: self)
            } else {
                self.numbersArr = numbers
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                    self.selectDefaultRow()
                }
            }
        }
    }
    
    func selectDefaultRow() {
        if (!splitViewController!.collapsed) {
            if numbersArr.count > 0 {
                 performSegueWithIdentifier("showDetail", sender: selectedIndexPath)
                 if let cell = tableView.cellForRowAtIndexPath(selectedIndexPath) as? NumberTableViewCell {
                    cell.setSelected(true, animated: true)
                 }
                 tableView.selectRowAtIndexPath(selectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NumberCell", forIndexPath: indexPath) as! NumberTableViewCell
        if let number = numberForIndexPath(indexPath) {
             cell.configureWithNumber(number)
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        performSegueWithIdentifier("showDetail", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            var detail: NumberDetailViewController
            if let navigationController = segue.destinationViewController as? UINavigationController {
                detail = navigationController.topViewController as! NumberDetailViewController
            } else {
                detail = segue.destinationViewController as! NumberDetailViewController
            }
                let number = numberForIndexPath(sender as! NSIndexPath)
                detail.numberName = number?.name
        }
    }
    
    func numberForIndexPath(indexPath: NSIndexPath) -> Number? {
        if (numbersArr.count > indexPath.row) {
            return numbersArr[indexPath.row]
        }
        return nil
    }
    
    func rotated() {
        if ((DeviceType.IS_PAD || DeviceType.IS_IPHONE_6P) && UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            self.selectDefaultRow()
        }
    }
}
