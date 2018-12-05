//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetAdasSwitch: BleMessageBase {
    public override init() {
        super.init()
        dataType = 0x09
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
            let ldw = data[1]
            let fcw = data[2]
            let fcwF = data[3]
            deviceSettingInfo.ldwSwitch = NSNumber(value: ldw)
            deviceSettingInfo.fcwSwitch = NSNumber(value: fcw)
            deviceSettingInfo.fcwFSwitch = NSNumber(value: fcwF)
            print("ldw:::::::::\(ldw)")
            print("fcw:::::::::\(fcw)")
            print("fcwF:::::::::\(fcwF)")
            
            responseData = data
        }
    }
}
