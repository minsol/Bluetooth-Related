//
//  BleMessageGetWarningVoiceVolume.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/17.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

final public class BleMessageGetWarningVoiceVolume: BleMessageBase {
    public override init() {
        super.init()
        dataType = 21
    }
    
    override func buildRequest() {
        super.buildRequest()
        if let type = deviceSettingInfo.voiceVolumeType {
            byteArray.append(type.uint8Value)
        }
        sendData = Data(bytes: byteArray)
    }
    
    override func parseResponse(data: Data?) {
        if let data = data {
            guard data[0] == dataType else{
                return
            }
            let voicetype = data[1]
            let volume = data[2]
            if voicetype == 0 {
                deviceSettingInfo.warningVoiceVolume =  NSNumber(value: volume)
            }else if voicetype == 1{
                deviceSettingInfo.edogVoiceVolume =  NSNumber(value: volume)
            }
            print("voicetype:::::::::\(voicetype)")
            print("volume:::::::::\(volume)")
            responseData = data
        }
    }
}


/*
 21、getwarningvoicevolume
 request：{21, voicetype, 0x00, 0x00, 0x00, 0x00, 0x00};
 voicetype:  0=告警声音大小
 1=电子狗/导航音量大小
 
 respond：type= b[0]；
 voicetype= b[1]
 volume= b[2]
 
 */
