//
//  VehicleVM.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 23.4.21..
//

import Foundation

struct VehicleVM {
    let title: String
    let imageUrlString: String
    let topSeperatorColor = DottColorAsset.closeButtonBackground.color
}

extension VehicleVM {
    init(vehicleCellVM: VehicleCellVM) {
        if vehicleCellVM.identificationCode == "" {
            self.title = "No code!!!"
        } else {
            self.title = "Scooter code: " + vehicleCellVM.identificationCode
        }
        self.imageUrlString = vehicleCellVM.qrURL
    }
}
