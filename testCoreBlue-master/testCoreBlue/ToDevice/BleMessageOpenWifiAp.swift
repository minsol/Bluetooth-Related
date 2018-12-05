//
//  BleMessageOpenWifiAp.swift
//  HttpMessage
//
//  Created by minsol on 2018/1/18.
//  Copyright © 2018年 Chris. All rights reserved.
//

import UIKit

final public class BleMessageOpenWifiAp: BleMessageBase {
    public override init() {
        super.init()
        dataType = 40
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
            resultCode = Int(data[1])
            responseData = data
        }
    }
}
