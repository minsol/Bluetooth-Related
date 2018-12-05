//
//  BleMessageSetWarningVoiceVolume.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageSetWarningVoiceVolume: BleMessageBase {
    public override init() {
        super.init()
        dataType = 22
    }
    
    override func buildRequest() {
        super.buildRequest()
        if let type = deviceSettingInfo.voiceVolumeType {
            byteArray.append(type.uint8Value)
            if type == 0 {
                if let volume = deviceSettingInfo.warningVoiceVolume {
                    byteArray.append(volume.uint8Value)
                }
            }else if type == 1{
                if let volume = deviceSettingInfo.edogVoiceVolume {
                    byteArray.append(volume.uint8Value)
                }
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
