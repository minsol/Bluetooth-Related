//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageSetAdasSwitch: BleMessageBase {
    public override init() {
        super.init()
        dataType = 10
    }
    
    override func buildRequest() {
        super.buildRequest()
        if case let (ldw?, fcw?, fcwF?) = (deviceSettingInfo.ldwSwitch, deviceSettingInfo.fcwSwitch, deviceSettingInfo.fcwFSwitch) {
            byteArray.append(ldw.uint8Value)
            byteArray.append(fcw.uint8Value)
            byteArray.append(fcwF.uint8Value)
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
