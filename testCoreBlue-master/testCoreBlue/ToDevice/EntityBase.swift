//
//  EntityBase.swift
//  JimuZX
//
//  Created by Chris on 2016/11/28.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

public class EntityBase: NSObject, NSCoding {

    public override init() {
        super.init()
    }

    init(dic: [String: Any]) {
        super.init()
        for case let (label?, _) in Mirror(reflecting: self).children {
            if let value = dic[label] as? String {
                setValue(value, forKey: label)
            }else if let value = dic[label] as? NSNumber {
                setValue(value, forKey: label)
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init()
        for case let (label?, _) in Mirror(reflecting: self).children {
            setValue(aDecoder.decodeObject(forKey: label), forKey: label)
        }
    }

    public func encode(with aCoder: NSCoder) {
        for case let (label?, _) in Mirror(reflecting: self).children {
            aCoder.encode(value(forKey: label), forKey: label)
        }
    }

    
    public func toDictionary() -> [String: Any] {
        var dic = [String: Any]()
        for case let (label?, value) in Mirror(reflecting: self).children {
            if let value = value as? NSNumber {
                dic[label] = value
            } else if let value = value as? String {
                dic[label] = value
            }
        }
        return dic
    }
}
