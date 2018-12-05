//
//  BluetoothAdaptor.swift
//  JimuQX
//
//  Created by minsol on 2018/1/16.
//  Copyright © 2018年 极目. All rights reserved.
//

import UIKit
import CoreBluetooth

final class BluetoothAdaptor: NSObject {
    static let sharedInstance = BluetoothAdaptor()

    fileprivate var centralManager: CBCentralManager?
    
    fileprivate let bleServiceUUID = CBUUID(string: "0000FFF9-0000-1000-8000-00805F9B34FB")
    
    fileprivate var blePeripheral: CBPeripheral?
    fileprivate let jimuDeviceName = "jimu600"

    /** 用于接收的特征*/
    fileprivate var readCharacteristic: CBCharacteristic!
    /** 用于发送的特征*/
    fileprivate var writeCharacteristic: CBCharacteristic!

    fileprivate let readCharacteristicUUID = CBUUID(string: "0000FFF1-0000-1000-8000-00805F9B34FB")
    fileprivate let writeCharacteristicUUID = CBUUID(string: "0000FFF2-0000-1000-8000-00805F9B34FB")

    var delegate : BleAdaptorMessageDelegate?
    
    
    var isConnectedJmBle: Bool = false
    var isConnected: Bool {
        get {
            if !self.isConnectedJmBle {
                startScan()
            }
            return self.isConnectedJmBle
        }
        set{
            if newValue {
                if let delegate = delegate {
                    delegate.bleConnected()
                }
            }
            isConnectedJmBle = newValue
        }
    }

    var isBlePoweredOn : Bool {
        switch centralManager?.state {
        case .poweredOn?:
            return true
        default:
            return false
        }
    }
    

    
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        enterForeground()
    }
    
    public func writeValue(_ data: Data){
        blePeripheral?.writeValue(data, for: writeCharacteristic, type: CBCharacteristicWriteType.withResponse)
    }
    
    @objc func enterForeground() {
        startScan()
    }

    @objc func enterBackground() {
        if let peripheral = blePeripheral {
            centralManager?.cancelPeripheralConnection(peripheral)
            blePeripheral = nil
        }
        stopScan()
    }

    func startScan() {
        if centralManager == nil {
            centralManagerInit()
        }
        isConnected = false
        centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
    }

    func stopScan() {
        centralManager?.stopScan()
    }
}

//MARK: - CBCentralManagerDelegate
extension BluetoothAdaptor: CBCentralManagerDelegate {

    fileprivate func centralManagerInit() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if let delegate = delegate {
            delegate.centralManagerDidUpdateState()
        }
        switch central.state {
        case .poweredOn:
            startScan()
        default:
            break;
        }
    }

    ///扫描到外设之后会调用
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let deviceName = advertisementData[CBAdvertisementDataLocalNameKey] as? String else {
            return
        }
//        if let data = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data {
//            print("data:::::::::\(data)")
//        }
//        print("deviceName:::::::::\(deviceName)")
        if deviceName == jimuDeviceName {
            blePeripheral = peripheral
            blePeripheral!.delegate = self
            central.connect(peripheral, options: nil)
        }
    }

    ///连接上外设之后会调用
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        print("blePeripheral:::::::::\(String(describing: blePeripheral))")
        peripheral.discoverServices(nil)
        stopScan()
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        print("didFailToConnect")
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        if let delegate = delegate {
            delegate.centralManagerDidUpdateState()
        }
//        print("didDisconnectPeripheral:\(String(describing: error))")
    }
}


// MARK: /******************************CBPeripheralDelegate代理*****************************************/
extension BluetoothAdaptor :CBPeripheralDelegate{

    ///扫描此外设对应的服务之后调用
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    ///扫描此服务对应的特征之后调用
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        print("didDiscoverCharacteristicsFor service::::\(service.uuid)")
//        print(":::::::::\(String(describing: service.characteristics?.count))")
        service.characteristics?.forEach { characteristic in
//            print("characteristic:\(characteristic.uuid)")
            if characteristic.uuid == readCharacteristicUUID{
                readCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: readCharacteristic)
            }else if characteristic.uuid == writeCharacteristicUUID{
                writeCharacteristic = characteristic
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
//        print("已经发送了给蓝牙:::::::::\(String(describing: characteristic.uuid))")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        print("didUpdateValueFor:::::::::\(String(describing: characteristic.value))")
        if let delegate = delegate {
            delegate.didUpdateValueForCharacteristic(characteristic: characteristic, error: error)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        isConnected = true
//        print("didUpdateNotificationStateFor:::::::::\(String(describing: characteristic.value))::::\(characteristic.uuid)")
    }
    
}




