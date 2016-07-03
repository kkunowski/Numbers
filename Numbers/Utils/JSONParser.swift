//
//  AppDelegate.swift
//  Numbers
//
//  Created by Krzysztof Kunowski on 03/07/16.
//  Copyright © 2016 Tapptic. All rights reserved.
//

import Foundation

public enum JSONError: ErrorType {
    case WrongType
    case WrongKey
}

public class JSONParser {
    
    var value: AnyObject
    
    public func valueAsString() throws -> String {
        guard let str = value as? String else {throw JSONError.WrongType}
        return str
    }
    
    public func valueAsDictionary() throws -> NSDictionary {
        guard let dict = value as? NSDictionary else {throw JSONError.WrongType}
        return dict
    }
    
    public func valueAsStringByKey(key: String) throws -> String {
        guard let str = try valueAsDictionary().valueForKey(key) as? String else {throw JSONError.WrongKey}
        return str
    }
    
    public func valueAsArray() throws -> NSArray {
        guard let arr = value as? NSArray else {throw JSONError.WrongType}
        return arr
    }
    
    /* TODO: implement other types when needen
     
     public func valueAsInt() throws -> Int { }
     
     public func valueAsBool() throws -> Bool { }
     
     public func valueAsArray() throws -> NSArray { }
     
    */
    
    public init(_ parseValue: AnyObject) throws {
        if let data = parseValue as? NSData {
            value = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
        } else {
            value = parseValue
        }
    }
    
}

public protocol JSON {
    init(_ parser: JSONParser) throws
}