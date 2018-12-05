//
//  BleAdaptor.swift
//  testCoreBlue
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol BleAdaptorMessageDelegate: class {
    ///获取蓝牙
    func didUpdateValueForCharacteristic(characteristic:CBCharacteristic,error:Error?) -> Void
    func centralManagerDidUpdateState() -> Void
    func bleConnected() -> Void
}


public class BleAdaptor: NSObject {
    public static let sharedInstance = BleAdaptor()
    var semaphore : DispatchSemaphore!
    var queue : DispatchQueue!

    var callBack : ((Data) -> Swift.Void)?
    
    public var isConnectedJmBle: Bool{
        return BluetoothAdaptor.sharedInstance.isConnectedJmBle
    }
    
    public var isBlePoweredOn : Bool {
        return BluetoothAdaptor.sharedInstance.isBlePoweredOn
    }
    let bleMessageConnectedBleNotification = Notification(name: Notification.Name("bleMessageConnectedBleNotification"))

    public var bleTestPrint = false
    private override init() {
        super.init()
        _ = BluetoothAdaptor.sharedInstance
        BluetoothAdaptor.sharedInstance.delegate = self
        semaphore = DispatchSemaphore(value: 1)
        queue = DispatchQueue(label: "BleQueue")
    }

    func writeValue(data:Data,callback: @escaping (Data) -> Swift.Void) {
        guard isConnectedJmBle else {
            return
        }
        queue.async {
            self.semaphore.wait()
            BluetoothAdaptor.sharedInstance.writeValue(data)
            self.callBack = callback
            if self.bleTestPrint {
                print("send::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")
            }
        }
    }
}

extension BleAdaptor:BleAdaptorMessageDelegate{
    func bleConnected() {
        if self.bleTestPrint {
            print("postBleMessageConnectedBleNotification::::::::::::::::::::::::::::::::::::")
        }
        DispatchQueue.main.async {
            NotificationCenter.default.post(self.bleMessageConnectedBleNotification)
        }
    }
    
    func didUpdateValueForCharacteristic(characteristic: CBCharacteristic, error: Error?) {
        if case let  (callBack?,value?) = (callBack,characteristic.value) {
            callBack(value)
            self.callBack = nil
            semaphore.signal()
            if self.bleTestPrint {
                print("recive::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")
            }
        }
    }
    
    func centralManagerDidUpdateState() {
        if self.bleTestPrint {
            print("reset:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::")
        }
        semaphore = DispatchSemaphore(value: 1)
    }
    
    
}
