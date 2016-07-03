//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import Foundation
import UIKit

struct Number : JSON {
    var name : String
    var imageUrl : String
    init(_ parser: JSONParser) throws {
        name = try parser.valueAsStringByKey("name")
        imageUrl = try parser.valueAsStringByKey("image")
    }
}

class TappticApiService {
    class func getNumbers(completeWith:([Number], NSError?) -> Void) {
        HTTP.GET("http://dev.tapptic.com/test/json.php") { (data : NSData?, error: NSError?) in
            do {
                if error == nil && data != nil {
                    if let result = try JSONParser(data!).value as? NSArray {
                        let numbers : [Number] = try result.map({ (value: AnyObject) -> Number in
                            do { return try Number(JSONParser(value)) }
                        })
                        completeWith(numbers, nil)
                    }
                } else {
                     completeWith([], error)
                }
            } catch let error as NSError {
                completeWith([], error)
            }
        }
    }
  
    class func getNumberByName(name: String, completeWith:(Number?, NSError?) -> Void) {
        HTTP.GET("http://dev.tapptic.com/test/json.php?name=\(name)") { (data : NSData?, error: NSError?) in
            do {
                if error == nil && data != nil {
                    if let result = try JSONParser(data!).value as? NSDictionary{
                        let number = try Number(JSONParser(result))
                        completeWith(number, nil)
                    }
                } else {
                    completeWith(nil, error)
                }
            } catch let error as NSError {
                completeWith(nil, error)
            }
        }
    }
    
}

