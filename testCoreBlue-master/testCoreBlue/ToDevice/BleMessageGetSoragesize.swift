//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetSoragesize: BleMessageBase {
    public override init() {
        super.init()
        dataType = 20
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
            let rangeArray:[NSNumber]  = [1,5,9,13,17]
            let stringArray = DataUtils.tranHexStr(toStrArray: hexStr, withRange: rangeArray)
            print("stringArray:::::::::\(String(describing: stringArray))")
            
            guard (stringArray != nil) && stringArray?.count == 5 else{
                return
            }
            
            let type = DataUtils.hexString(toAlgorism: stringArray![0])
            let totalSize = DataUtils.hexString(toAlgorism: stringArray![1])
            let freeSize = DataUtils.hexString(toAlgorism: stringArray![2])
            let videoSize = DataUtils.hexString(toAlgorism: stringArray![3])
            let pictureSize = DataUtils.hexString(toAlgorism: stringArray![4])
            

            guard totalSize != 0 else{
                return
            }
            deviceSettingInfo.totalSize = NSNumber(value: totalSize)
            deviceSettingInfo.freeSize = NSNumber(value: freeSize)
            deviceSettingInfo.videoSize = NSNumber(value: videoSize)
            deviceSettingInfo.pictureSize = NSNumber(value: pictureSize)
            
            print("type:::::::::\(type)")
            print("totalSize:::::::::\(totalSize)")
            print("freeSize:::::::::\(freeSize)")
            print("videoSize:::::::::\(videoSize)")
            print("pictureSize:::::::::\(pictureSize)")
            
            responseData = data
        }
    }
}
