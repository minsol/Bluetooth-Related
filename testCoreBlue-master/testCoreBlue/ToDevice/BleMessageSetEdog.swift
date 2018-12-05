//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageSetEdog: BleMessageBase {
    public override init() {
        super.init()
        dataType = 34
    }
    
    override func buildRequest() {
        super.buildRequest()
        if case let (edogTrafficInfo?, edogCameraInfo?) = (deviceSettingInfo.edogTrafficInfo, deviceSettingInfo.edogCameraInfo) {
            byteArray.append(edogTrafficInfo.uint8Value)
            byteArray.append(edogCameraInfo.uint8Value)
        }
        
        sendData = Data(bytes: byteArray)
    }
    
    override func parseResponse(data: Data?) {
        if let data = data {
            guard data[0] == dataType else{
                return
            }
            resultCode = Int(data[1])
            responseData = data
        }
    }
}
