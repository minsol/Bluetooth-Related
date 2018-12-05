//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetAdasParam: BleMessageBase {
    public override init() {
        super.init()
        dataType = 0x05
    }
    
    override func buildRequest() {
        super.buildRequest()
        sendData = Data(bytes: byteArray)
    }
    
    override func parseResponse(data: Data?) {
        if let data = data {
            guard data[0] == dataType else{
                return
            }
            let hexStr = DataUtils.data(toHexStr: data)
            let stringLength = hexStr?.lengthOfBytes(using: .utf8)
//            print("stringLength:::::::::\(String(describing: stringLength))")
            
            guard stringLength == 34 else{
                return
            }
            let rangeArray :[NSNumber]  = [1,5,9,13,17]
            let stringArray = DataUtils.tranHexStr(toStrArray: hexStr, withRange: rangeArray)
            
            guard (stringArray != nil) && stringArray?.count == 5 else{
                return
            }
            print("stringArray:::::::::\(String(describing: stringArray))")
            let type = DataUtils.hexString(toAlgorism: stringArray![0])
            let carHeight = DataUtils.hexString(toAlgorism: stringArray![1])
            let frontEdge = DataUtils.hexString(toAlgorism: stringArray![2])
            let leftEdge = DataUtils.hexString(toAlgorism: stringArray![3])
            let rightEdge = DataUtils.hexString(toAlgorism: stringArray![4])

            deviceSettingInfo.carHeight = NSNumber(value: carHeight)
            deviceSettingInfo.frontEdge = NSNumber(value: frontEdge)
            deviceSettingInfo.leftEdge = NSNumber(value: leftEdge)
            deviceSettingInfo.rightEdge = NSNumber(value: rightEdge)

            responseData = data
            print("type:::::::::\(type)")
            print("carHeight:::::::::\(carHeight)")
            print("frontEdge:::::::::\(frontEdge)")
            print("leftEdge:::::::::\(leftEdge)")
            print("rightEdge:::::::::\(rightEdge)")

            responseData = data
        }
    }
}
