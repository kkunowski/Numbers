//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import Foundation

class HTTP {
    
    class func GET(url: String, completeWith:(data: NSData?, NSError?)->Void) {
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: url)!), queue: NSOperationQueue(), completionHandler:{ (response:   NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            error == nil ? completeWith(data: data, error) :completeWith(data: nil, error)
        })}
    
    /* TODO: implement other types when needen
     
     class func POST(url: String, data: NSData, completeWith:(data: NSData?, NSError?)->Void) { }
     class func PUT(url: String, data: NSData, completeWith:(data: NSData?, NSError?)->Void) { }
     
     */
}
