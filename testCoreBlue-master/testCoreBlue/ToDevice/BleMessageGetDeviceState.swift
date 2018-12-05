//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetDeviceState: BleMessageBase {
    public override init() {
        super.init()
        dataType = 35
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
            
            let sim = data[1]
            let gps = data[2]
            let sd = data[3]
            let ble = data[4]
            let power = data[5]
            let powerLevel = data[6]
            
            deviceSettingInfo.sim = NSNumber(value: sim)
            deviceSettingInfo.gps = NSNumber(value: gps)
            deviceSettingInfo.sd = NSNumber(value: sd)
            deviceSettingInfo.ble = NSNumber(value: ble)
            deviceSettingInfo.power = NSNumber(value: power)
            deviceSettingInfo.powerLevel = NSNumber(value: powerLevel)
            
            print("sim:::::::::\(sim)")
            print("gps:::::::::\(gps)")
            print("sd:::::::::\(sd)")
            print("ble:::::::::\(ble)")
            print("power:::::::::\(power)")
            print("powerLevel:::::::::\(powerLevel)")

            
            responseData = data
        }
    }
}
