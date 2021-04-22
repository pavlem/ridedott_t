//
//  VehicleCellVM.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 22.4.21..
//

import UIKit

struct VehicleCellVM {
    var color: String
    var qrURL: String
    var identificationCode: String
}

extension VehicleCellVM {

    var vehicleImage: UIImage? { return UIImage(named: vehicleImageName ?? "scooter") }
    
    var vehicleImageName: String? {
        return "icon/\(colorDictionary[color] ?? "scooter")"
    }
    
    static func filter(vehicles: [VehicleCellVM], with colorStrings: [String], totalNumberOfFilters: Int) -> [VehicleCellVM]? {
        
        guard colorStrings.count < totalNumberOfFilters else { return nil }
        
        var fVehicles = [VehicleCellVM]()
        for filterString in colorStrings {
            fVehicles += vehicles.filter { $0.color == filterString }
        }
        return fVehicles.count > 0 ? fVehicles : nil
    }
    
    private var colorDictionary: [String: String] {
        return [
            "BlueRed": "blueRedScooter",
            "YellowBlue": "yellowBlueScooter",
            "RedGreen": "redGreenScooter",
            "PinkYellow": "pinkYellowScooter"
        ]
    }
}

extension VehicleCellVM {
    init(vehicle: Vehicle) {
        color = vehicle.color
        qrURL = vehicle.qrURL
        identificationCode = vehicle.identificationCode
    }
}
