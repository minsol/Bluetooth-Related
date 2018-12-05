//
//  BleMessageBase.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit

public class BleMessageBase: NSObject {
    public let deviceSettingInfo = DeviceSettingInfo()

    var dataType : UInt8 = 0x01
    var byteArray  = [UInt8]()
    
    public var resultCode : Int?
    
    public var bleResultCode: Int {
        if let code = resultCode {
            return code
        }
        
        if (responseData != nil) {
            return 1
        }
        return 0
    }
    
    var sendData = Data()
    var responseData : Data?

    func send(callback: @escaping (Int) -> Swift.Void) {
        buildRequest()
        
        print(":::::::::\(self.classForCoder)")
        print("byteArray:::::::::\(byteArray)")
        print("sendData:::::::::\(sendData)")
        let hexStr = DataUtils.data(toHexStr: sendData)
        print("hexStr:::::::::\(String(describing: hexStr))")
        BleAdaptor.sharedInstance.writeValue(data: sendData) { (data) in
            self.parseResponse(data: data)
            callback(self.bleResultCode)
        }
    }
    
    ///对象转data
    func buildRequest() {
        let header = "J".data(using: .utf8)
        byteArray.append(header![0])
        byteArray.append(dataType)
        responseData = nil
        resultCode = nil
    }
    
    ///data转对象
    func parseResponse(data: Data?) {
        
    }
}
