//
//  FiltersViewController.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 22.4.21..
//

import UIKit


class FiltersViewController: SwipeableViewController {

    // MARK: - API
    var getColorFilters: (([String]) -> Void)?
    var closeColorFilter: (() -> Void)?
    var vm: FiltersVM = FiltersVM()
    
    // MARK: - Properties
    @IBOutlet weak var topSeperatorColorView: UIView!
    @IBOutlet weak var yellowBlueSwitch: UISwitch!
    @IBOutlet weak var pinkYellowSwitch: UISwitch!
    @IBOutlet weak var blueRedSwitch: UISwitch!
    @IBOutlet weak var redGreenSwitch: UISwitch!
    @IBOutlet var switches: [UISwitch]!
    private var areAllFiltersEnabled: Bool {
        return switches.allSatisfy({ $0.isOn })
    }
    private var isThereAnyFilter: Bool {
        return switches.contains {$0.isOn}
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    // MARK: - Helper
    private func setUI() {
        if let filteringStringArr = UserDefaultsHelper.shared.colorsFilter {
            vm = FiltersVM(filteringStringArray: filteringStringArr)
        }
        
        yellowBlueSwitch.isOn = vm.isYellowBlueSwitchOn
        pinkYellowSwitch.isOn = vm.isPinkYellowSwitchOn
        blueRedSwitch.isOn = vm.isBlueRedSwitchOn
        redGreenSwitch.isOn = vm.isRedGreenSwitchOn
        topSeperatorColorView.backgroundColor = vm.topSeperatorColor
    }
    
    private func getColorsFilter() -> [String] {
        var filterSet = Set<String>()
        
        if areAllFiltersEnabled {
            for filterString in FiltersVehicleType.colorFilters {
                filterSet.insert(filterString)
            }
            return Array(filterSet)
        }
        
        if yellowBlueSwitch.isOn { filterSet.insert(FiltersVehicleType.yellowBlue.descriptionForFiltering) }
        if pinkYellowSwitch.isOn { filterSet.insert(FiltersVehicleType.pinkYellow.descriptionForFiltering) }
        if blueRedSwitch.isOn { filterSet.insert(FiltersVehicleType.blueRed.descriptionForFiltering) }
        if redGreenSwitch.isOn { filterSet.insert(FiltersVehicleType.redGreen.descriptionForFiltering) }
        
        return Array(filterSet)
    }
    
    // MARK: - Actions
    override func swipeDown() {
        closeColorFilter?()
    }
    
    @IBAction func applyFiltering(_ sender: PrimaryButton) {
        guard isThereAnyFilter else {
            AlertHelper.simpleAlert(message: vm.noFilterMessage, vc: self) {}
            return
        }

        let colorsFilter = getColorsFilter()
        UserDefaultsHelper.shared.colorsFilter = colorsFilter
        getColorFilters?(colorsFilter)
    }
    
    @IBAction func closeFilter(_ sender: CloseButton) {
        closeColorFilter?()
    }
}
