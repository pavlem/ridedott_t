//
//  VehicleCell.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 22.4.21..
//

import UIKit

class VehicleCell: UITableViewCell {
    
    // MARK: - API
    var vm: VehicleCellVM? {
        willSet {
            setUI(vm: newValue)
        }
    }
    
    static let cellId = "VehicleCell"
    static let cellNibName = "VehicleCell"

    // MARK: - Properties
    @IBOutlet weak var vehicleImgView: UIImageView!
    @IBOutlet weak var vehicleLbl: UILabel!

    // MARK: - Helper
    private func setUI(vm: VehicleCellVM?) {
        guard let vm = vm else { return }
        vehicleImgView.image = vm.vehicleImage
        vehicleLbl.text = vm.identificationCode
    }
}
