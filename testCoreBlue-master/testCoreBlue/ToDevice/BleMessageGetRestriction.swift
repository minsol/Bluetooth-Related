//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetRestriction: BleMessageBase {
    public override init() {
        super.init()
        dataType = 0x07
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
            print("hexStr:::::::::\(String(describing: hexStr))")
            
            guard stringLength == 40 else{
                return
            }
            let rangeArray:[NSNumber]  = [1,10,11,15,19,20]
            let stringArray = DataUtils.tranHexStr(toStrArray: hexStr, withRange: rangeArray)
            print("stringArray:::::::::\(String(describing: stringArray))")
            
            guard (stringArray != nil) && stringArray?.count == 6 else{
                return
            }
            let type = DataUtils.hexString(toAlgorism: stringArray![0])
            let carNumber = DataUtils.convertHexStr(to: stringArray![1])
            let restriction = DataUtils.hexString(toAlgorism: stringArray![2])
            let vehicleHeight = DataUtils.hexString(toAlgorism: stringArray![3])
            let vehicleLoad = DataUtils.hexString(toAlgorism: stringArray![4])
            let vehicleLoadSwitch = DataUtils.hexString(toAlgorism: stringArray![5])
            
            
            
            deviceSettingInfo.mCarNumber = carNumber
            deviceSettingInfo.restriction = NSNumber(value: restriction)
            deviceSettingInfo.mVehicleHeight = NSNumber(value:  Double(vehicleHeight)/1000.0)
            deviceSettingInfo.mVehicleLoad = NSNumber(value:  Double(vehicleLoad)/1000.0)
            deviceSettingInfo.vehicleLoadSwitch = NSNumber(value: vehicleLoadSwitch)
            

            responseData = data
            print("type:::::::::\(type)")
            print("carNumber:::::::::\(String(describing: carNumber))")
            print("restriction:::::::::\(restriction)")
            print("vehicleHeight:::::::::\(vehicleHeight)")
            print("vehicleLoad:::::::::\(vehicleLoad)")
            print("vehicleLoadSwitch:::::::::\(vehicleLoadSwitch)")
            responseData = data
        }
    }
}
