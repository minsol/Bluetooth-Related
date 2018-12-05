//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageSetRestriction: BleMessageBase {
    public override init() {
        super.init()
        dataType = 0x08
    }
    
    override func buildRequest() {
        super.buildRequest()
        if case let ( mCarNumber?, restriction?) = (deviceSettingInfo.mCarNumber,deviceSettingInfo.restriction) {
            print("mCarNumber:::::::::\(mCarNumber)")
            let number = mCarNumber.data(using: .utf8)
            number?.forEach({ (byte) in
                byteArray.append(byte)
            })
            print("number:::::::::\(String(describing: number))")


//            let header = "鄂a12345".data(using: .utf8)
//            print("header:::::::::\(String(describing: header))")
//            header?.forEach({ (byte) in
//                byteArray.append(byte)
//            })

            byteArray.append(restriction.uint8Value)
            if case let (mVehicleHeight?, mVehicleLoad?, vehicleLoadSwitch?) = (deviceSettingInfo.mVehicleHeight,
                                                                                deviceSettingInfo.mVehicleLoad,
                                                                                deviceSettingInfo.vehicleLoadSwitch) {
                let array = [mVehicleHeight.int32Value * 1000,mVehicleLoad.int32Value * 1000]
                array.forEach({ (value) in
                    for i in 0 ..< 4 {
                        let value = (value >> Int32(8*i)) & 0xff
                        byteArray.append(UInt8(value))
                    }
                })
//                byteArray.append(vehicleLoadSwitch.uint8Value)
            }
        }
        
        sendData = Data(bytes: byteArray)
    }
    
    override func parseResponse(data: Data?) {
        if let data = data {
            guard data[0] == dataType else{
                return
            }
            responseData = data
        }
    }
}
