//
//  BleMessageReserBle.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetWarningVoiceType: BleMessageBase {
    public override init() {
        super.init()
        dataType = 13
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
            let voicetype = data[1]
            deviceSettingInfo.warningVoiceType = NSNumber(value: voicetype)
            responseData = data
        }
    }
}
