//
//  VehicleViewController.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 22.4.21..
//

import UIKit

class VehicleViewController: SwipeableViewController {
    
    var vm: VehicleVM?
    var closeColorFilter: (() -> Void)?
    
    // MARK: - Properties
    @IBOutlet weak var topSeperatorColorView: UIView!
    @IBOutlet weak var qrCodeImgView: DottImageView!
    @IBOutlet weak var vehicleIdLbl: TitleLabel!
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataTask?.cancel()
    }
    
    // MARK: - Helper
    private func setUI() {
        guard let vm = vm else { return }
        vehicleIdLbl.text = vm.title
        if let url = URL(string: vm.imageUrlString) {
            dataTask = qrCodeImgView.downloadImage(from: url)
        }
        
        topSeperatorColorView.backgroundColor = vm.topSeperatorColor
    }

    // MARK: - Actions
    @IBAction func closeVehicle(_ sender: CloseButton) {
        closeColorFilter?()
    }
    
    override func swipeDown() {
        closeColorFilter?()
    }
}
