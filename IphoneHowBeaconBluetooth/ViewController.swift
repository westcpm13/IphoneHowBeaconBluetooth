//
//  ViewController.swift
//  IphoneHowBeaconBluetooth
//
//  Created by Pawel Trojan on 10.07.2017.
//  Copyright © 2017 Pawel Trojan. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController {

    private var region: CLBeaconRegion?
    private final let sampleUUID = "B2DCB64-3300-4G62-8A11-F6E7A06E4BC0"
    private var peripheralManager: CBPeripheralManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.region = CLBeaconRegion(proximityUUID: UUID(uuidString: self.sampleUUID)!, identifier: "com.ptrojan.IphoneHowBeaconBluetooth")
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.main)
    }
}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        var statusMessage = ""
        
        switch peripheral.state {
        case .poweredOn:
            statusMessage = "Bluetooth Status: Turned On"
            
        case .poweredOff:
            statusMessage = "Bluetooth Status: Turned Off"
            
        case .resetting:
            statusMessage = "Bluetooth Status: Resetting"
            
        case .unauthorized:
            statusMessage = "Bluetooth Status: Not Authorized"
            
        case .unsupported:
            statusMessage = "Bluetooth Status: Not Supported"
            
        default:
            statusMessage = "Bluetooth Status: Unknown"
        }
        
        print(statusMessage)
        
    }

}
