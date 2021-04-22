//
//  FiltersVM.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 24.4.21..
//

import UIKit

struct FiltersVM {
    var isYellowBlueSwitchOn = true
    var isPinkYellowSwitchOn = true
    var isBlueRedSwitchOn = true
    var isRedGreenSwitchOn = true
    
    let topSeperatorColor = DottColorAsset.closeButtonBackground.color
    let noFilterMessage = "Please select at least one filter"
}

extension FiltersVM {
    init(filteredVehicles: [VehicleCellVM]?) {
        guard let vehicles = filteredVehicles else { return }
        
        isYellowBlueSwitchOn = vehicles.contains(where: { $0.color == FiltersVehicleType.yellowBlue.descriptionForFiltering})
        isPinkYellowSwitchOn = vehicles.contains(where: { $0.color == FiltersVehicleType.pinkYellow.descriptionForFiltering})
        isBlueRedSwitchOn = vehicles.contains(where: { $0.color == FiltersVehicleType.blueRed.descriptionForFiltering})
        isRedGreenSwitchOn = vehicles.contains(where: { $0.color == FiltersVehicleType.redGreen.descriptionForFiltering})
    }
    
    init(filteringStringArray: [String]) {
        
        if filteringStringArray.contains(where: { $0 == FiltersVehicleType.yellowBlue.descriptionForFiltering}) {  isYellowBlueSwitchOn = true } else {
            isYellowBlueSwitchOn = false
        }
        
        if filteringStringArray.contains(where: { $0 == FiltersVehicleType.pinkYellow.descriptionForFiltering}) {  isPinkYellowSwitchOn = true } else {
            isPinkYellowSwitchOn = false
        }
        
        if filteringStringArray.contains(where: { $0 == FiltersVehicleType.blueRed.descriptionForFiltering}) {  isBlueRedSwitchOn = true } else {
            isBlueRedSwitchOn = false
        }
        
        if filteringStringArray.contains(where: { $0 == FiltersVehicleType.redGreen.descriptionForFiltering}) {  isRedGreenSwitchOn = true } else {
            isRedGreenSwitchOn = false
        }
    }
}

enum FiltersVehicleType {
    case yellowBlue
    case pinkYellow
    case blueRed
    case redGreen
}

extension FiltersVehicleType {
    var descriptionForFiltering: String {
        switch self {
        case.yellowBlue:
            return "YellowBlue"
        case.pinkYellow:
            return "PinkYellow"
        case.blueRed:
            return "BlueRed"
        case.redGreen:
            return "RedGreen"
        }
    }
    
    static var colorFilters: [String] {
        return [
            FiltersVehicleType.yellowBlue.descriptionForFiltering,
            FiltersVehicleType.pinkYellow.descriptionForFiltering,
            FiltersVehicleType.blueRed.descriptionForFiltering,
            FiltersVehicleType.redGreen.descriptionForFiltering
        ]
    }
}
