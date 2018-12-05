//
//  BleMessageGetBleInfo.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetBleInfo: BleMessageBase {

    public override init() {
        super.init()
        dataType = 0x01
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
            let rangeArray:[NSNumber]  = [1,15,16,17]
            let stringArray = DataUtils.tranHexStr(toStrArray: hexStr, withRange: rangeArray)
//            print("stringArray:::::::::\(String(describing: stringArray))")

            guard (stringArray != nil) && stringArray?.count == 4 else{
                return
            }
            let type = DataUtils.hexString(toAlgorism: stringArray![0])
            let name = DataUtils.convertHexStr(to: stringArray![1])
            let calibrationCount = DataUtils.hexString(toAlgorism: stringArray![2])
            let power = DataUtils.hexString(toAlgorism: stringArray![3])
            
            
            deviceSettingInfo.bleName = name
            deviceSettingInfo.bleCalibrationCount = NSNumber(value: calibrationCount)
            deviceSettingInfo.blePower = NSNumber(value: power)
            responseData = data
            print("type:::::::::\(type)")
            print("name:::::::::\(String(describing: name))")
            print("calibrationCount:::::::::\(calibrationCount)")
            print("power:::::::::\(power)")
        }
    }
}

/*
 //获得标定信息getbleinfo
 request：{0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 respond： type= b[0]；
 name= b[1-14]；
 calibrationCount=b[15]
 power=b[16]
 */



