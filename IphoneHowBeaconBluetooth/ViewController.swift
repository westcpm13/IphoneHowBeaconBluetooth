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

enum StateAdvertising {
    case search
    case pause
}

class ViewController: UIViewController {

    @IBOutlet weak var advertisingLabel: UILabel!
    
    private var region: CLBeaconRegion?
    private final let sampleUUID = "3B2DCB64-A300-4F62-8A11-F6E7A06E4BC0"
    private var peripheralManager: CBPeripheralManager?
    private var stateAdvertising: StateAdvertising = .pause
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.region = CLBeaconRegion(proximityUUID: UUID(uuidString: self.sampleUUID)!, identifier: "com.ptrojan.IphoneHowBeaconBluetooth")
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.main)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        guard self.peripheralManager?.state == .poweredOn else {
            let alertVC = UIAlertController(title: "Bluetooth", message: "Turn On Bluetooth", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        switch self.stateAdvertising {
        case .pause:
          self.stateAdvertising = .search
          self.advertisingLabel.text = "Advertising..."
          sender.setTitle("Stop Advertising", for: .normal)
          let dict = self.region?.peripheralData(withMeasuredPower: -60)
          self.peripheralManager?.startAdvertising(dict as? [String : Any])
        
        case .search:
          self.stateAdvertising = .pause
          self.advertisingLabel.text = "Stop Advertising"
          sender.setTitle("Start Advertising", for: .normal)
          self.peripheralManager?.stopAdvertising()
        }
      
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
