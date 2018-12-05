//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetEdog: BleMessageBase {
    public override init() {
        super.init()
        dataType = 33
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
            let trafficInfo = data[1]
            let cameraInfo = data[2]
            deviceSettingInfo.edogTrafficInfo = NSNumber(value: trafficInfo)
            deviceSettingInfo.edogCameraInfo = NSNumber(value: cameraInfo)
            responseData = data
        }
    }
}
