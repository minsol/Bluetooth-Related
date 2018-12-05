//
//  ViewController.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = BleAdaptor.sharedInstance
    }
    
    
    @IBAction func send(_ sender: UIButton) {
//        let message = BleMessageGetBleInfo()1
        let message = BleMessageReserBle()
//
        let message1 = BleMessageGetCarType()
//        let message = BleMessageSetCarType()
//
        let message2 = BleMessageGetAdasParam()
//        let message = BleMessageSetAadasParam()1
//
        let message3 = BleMessageGetRestriction()
//        let message = BleMessageSetRestriction()?
//
        let message4 = BleMessageGetAdasSwitch()
//        let message = BleMessageSetAdasSwitch()1
//
        let message5 = BleMessageGetWarningLevel()
//        let message = BleMessageSetWarningLevel()1
//
//        let message = BleMessageGetWarningVoiceType()1
        //        let message = BleMessageSetWarningVoiceType()1:没有响
//
//        let message = BleMessageCappicture()1
//
//        let message = BleMessageGetRecordState()1
//        let message = BleMessageSetRecordState()
//
//        let message = BleMessageGetVideoVoice()
//        let message = BleMessageSetVideoVoice()
//        
//        let message = BleMessageGetSoragesize()
//        let message = BleMessageGetWarningVoiceVolume()
//        let message = BleMessageSetWarningVoiceVolume()
//        
//        let message = BleMessageClearCache()
//        
//        let message = BleMessageSetEdog()
//        let message = BleMessageGetEdog()
//
//        let message = BleMessageGetDeviceState()
//        let message = BleMessageStartNavi()
//        let message = BleMessageStopNavi()
//        let message = BleMessageGetNaviState()
//        let message = BleMessageGetNavisState2()
        message.deviceSettingInfo.carHeight = NSNumber(value: 100)
        message.deviceSettingInfo.frontEdge = NSNumber(value: 80)
        message.deviceSettingInfo.leftEdge = NSNumber(value: 200)
        message.deviceSettingInfo.rightEdge = NSNumber(value: 150)
        
        message.deviceSettingInfo.carType = NSNumber(value: 2)
        message.deviceSettingInfo.ldwSwitch = NSNumber(value: 1)
        message.deviceSettingInfo.fcwSwitch = NSNumber(value: 1)
        message.deviceSettingInfo.fcwFSwitch = NSNumber(value: 1)
        message.deviceSettingInfo.warningLevel = NSNumber(value: 1)
        message.deviceSettingInfo.voiceVolumeType = NSNumber(value: 1)
        message.deviceSettingInfo.recordState = NSNumber(value: 1)
        message.deviceSettingInfo.videoVoice = NSNumber(value: 10)
        message.deviceSettingInfo.edogCameraInfo = NSNumber(value: 1)
        message.deviceSettingInfo.edogCameraInfo = NSNumber(value: 1)
        message.deviceSettingInfo.voiceVolumeType = NSNumber(value: 0)
        message.deviceSettingInfo.voiceVolumeType = NSNumber(value: 0)
        message.deviceSettingInfo.warningVoiceVolume = NSNumber(value: 80)
        message.send { (code) in
            print("code:::::::::\(code)")
        }
        message1.send { (code) in
            print("code:::::::::\(code)")
        }
        message2.send { (code) in
            print("code:::::::::\(code)")
        }
        message3.send { (code) in
            print("code:::::::::\(code)")
        }
        message4.send { (code) in
            print("code:::::::::\(code)")
        }
        message5.send { (code) in
            print("code:::::::::\(code)")
        }
        

        
        let message6 = BleMessageSetRestriction()
        message6.deviceSettingInfo.mCarNumber = "鄂a12345"
        message6.deviceSettingInfo.restriction = NSNumber(value: 1)
        message6.deviceSettingInfo.mVehicleHeight = NSNumber(value: 10)
        message6.deviceSettingInfo.mVehicleLoad = NSNumber(value: 10)
        message6.deviceSettingInfo.vehicleLoadSwitch = NSNumber(value: 1)
        message6.send { (code) in
            print("code:::::::::\(code)")
        }

//        let s = DataUtils.utf8(toUnicode: "鄂a12345")
//        let data = DataUtils.hexStr(toData: s)
//        print("s:::::::::\(String(describing: s))")
//        print("data:::::::::\(data)")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

