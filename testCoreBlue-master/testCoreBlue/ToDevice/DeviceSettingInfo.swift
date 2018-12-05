//
//  DeviceSettingInfo.swift
//  JimuZX
//
//  Created by Chris on 2016/11/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

final public class DeviceSettingInfo: EntityBase {
    public var warningLevel: NSNumber?
    public var fcwSwitch: NSNumber?
    public var fcwFSwitch: NSNumber?
    public var ldwSwitch: NSNumber?
    public var carType: NSNumber?
    public var warningVoiceType: NSNumber?     //0: 语音; 1: 铃声
    public var warningVoiceState: NSNumber?
    
    public var voiceVolumeType: NSNumber?     //0: 警告; 1: 电子狗
    public var warningVoiceVolume: NSNumber?// 警告
    public var edogVoiceVolume: NSNumber?//电子狗

    public var recordState: NSNumber?
    public var videoVoice: NSNumber?

    //SD卡状态
    public var totalSize: NSNumber?
    public var freeSize: NSNumber?
    public var videoSize: NSNumber?
    public var pictureSize: NSNumber?

    //电子狗
    public var edogTrafficInfo: NSNumber?
    public var edogCameraInfo: NSNumber?

    //蓝牙传感器状态
    public var bleName: String?
    public var bleCalibrationCount: NSNumber?
    public var blePower: NSNumber?

    //蓝牙LED状态
    public var ledName: String?
    public var ledConnected: NSNumber?
    public var ledBinding: NSNumber?

    //"sim": 0, "gps": 1, "sd": 1, "ble": 1, "power": 2, "powerLevel": 100
    //设备状态
    public var sim: NSNumber?
    public var gps: NSNumber?
    public var sd: NSNumber?
    public var ble: NSNumber?
    public var power: NSNumber?
    public var powerLevel: NSNumber?

    public var carHeight: NSNumber?
    public var frontEdge: NSNumber?
    public var leftEdge: NSNumber?
    public var rightEdge: NSNumber?

    
    //车辆限行设置
    public var mCarNumber: String?
    public var restriction: NSNumber?
    
    public var mVehicleHeight: NSNumber?
    public var mVehicleLoad: NSNumber?
    public var vehicleLoadSwitch: NSNumber?


    public func refreshInfo(info: DeviceSettingInfo) {
        for case let (label?, value) in Mirror(reflecting: info).children {
            if let value = value as? NSNumber {
                setValue(value, forKey: label)
            } else if let value = value as? String {
                setValue(value, forKey: label)
            }
        }
    }
}
