//
//  MsgpackSwampSerializer.swift
//  Swamp
//
//  Created by Eli Burke on 10/12/16.
//

import Foundation
import MessagePack

open class MsgpackSwampSerializer: SwampSerializer {

    public init() {}
    
    open func anyToMPValue(anyVal : Any) -> MessagePackValue? {
        
        switch(anyVal) {
            
        case is Bool:
            print("Bool")
            return MessagePackValue(anyVal as! Bool)
            
        case is Int: // will not handle Int8, Int16, Int32, Int64
            print("Int")
            return MessagePackValue(anyVal as! Int)
            
        case is UInt: // does not handle UInt8, UInt16, UInt32, UInt64
            print("UInt")
            return MessagePackValue(anyVal as! UInt)
            
        case is Float:
            print("Float")
            return MessagePackValue(anyVal as! Float)
            
        case is Double:
            print("Double")
            return MessagePackValue(anyVal as! Double)
            
        case is String:
            print("String")
            return MessagePackValue(anyVal as! String)
            
        case is Array<Any>:
            print("Array")
            var mpArray = Array<MessagePackValue>()

            let arrayVal = anyVal as! Array<Any>
            for value in arrayVal {
                if let mpValue = anyToMPValue(anyVal: value) {
                    mpArray.append(mpValue)
                } else {
                    print("failed to convert")
                    print(value)
                }
            }
            return MessagePackValue(mpArray)
            
        case is Dictionary<String, Any>:
            print("Dictionary")
            var mpDict = [MessagePackValue : MessagePackValue]()

            let dictVal = anyVal as! Dictionary<String, Any>
            for (key,value) in dictVal {
                let mpKey = MessagePackValue(key)
                if let mpValue = anyToMPValue(anyVal: value) {
                    mpDict[mpKey] = mpValue
                } else {
                    print("failed to convert")
                    print(value)
                }
            }
            return MessagePackValue(mpDict)
            
        case is Data:
            print("Data")
            return MessagePackValue(anyVal as! Data)
            
        default:
            print("Unknown type")
            return nil;
        }
    }
    
    open func pack(_ data: [MessagePackValue]) -> Data? {
        var packed = Data()
        
        for mpValue in data {
            packed.append(MessagePack.pack(mpValue))
        }
        return packed
    }
    
    open func pack(_ data: [Any]) -> Data? {
        var packed = Data()
        
//        for value in data {
//            if let mpValue = anyToMPValue(anyObj: value) {
//                packed.append(MessagePack.pack(mpValue))
//            }
//        }
        
        if let mpValue = anyToMPValue(anyVal: data) {
            packed.append(MessagePack.pack(mpValue))
        }
        
        return packed
    }
    
    open func unpack(_ data: Data) -> [Any]? {
        do {
            return try unpackAll(data) as [Any]?
        }
        catch {
            return nil
        }
    }
}
