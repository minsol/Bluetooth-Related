//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageSetAadasParam: BleMessageBase {
    public override init() {
        super.init()
        dataType = 0x06
    }
    
    override func buildRequest() {
        super.buildRequest()
        if case let (carHeight?, frontEdge?, leftEdge?, rightEdge?) = (deviceSettingInfo.carHeight,
                                                                       deviceSettingInfo.frontEdge,
                                                                       deviceSettingInfo.leftEdge,
                                                                       deviceSettingInfo.rightEdge) {
            
//            let da = DataUtils.intValue(toByteArray: carHeight.int32Value)
//            print("da:::::::::\(da![0])")
            let array = [carHeight,frontEdge,leftEdge,rightEdge]
            array.forEach({ (value) in
                for i in 0 ..< 4 {
                    let value = (value.int32Value >> Int32(8*i)) & 0xff
                    byteArray.append(UInt8(value))
                }
            })
        }
        sendData = Data(bytes:byteArray)
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
