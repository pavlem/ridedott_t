//
//  iOS_assignmentTests.swift
//  iOS-assignmentTests
//

import XCTest
@testable import iOS_assignment

class iOS_assignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testImageInVehicleCellVM() {

        let sVM1 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "")
        let sVM2 = VehicleCellVM(color: "YellowBlue", qrURL: "", identificationCode: "")
        let sVM3 = VehicleCellVM(color: "PinkYellow", qrURL: "", identificationCode: "")
        let sVM4 = VehicleCellVM(color: "RedGreen", qrURL: "", identificationCode: "")
        let sVM5 = VehicleCellVM(color: "RedGreen2", qrURL: "", identificationCode: "")

        XCTAssert(sVM1.vehicleImageName == "icon/blueRedScooter")
        XCTAssert(sVM2.vehicleImageName == "icon/yellowBlueScooter")
        XCTAssert(sVM3.vehicleImageName == "icon/pinkYellowScooter")
        XCTAssert(sVM4.vehicleImageName == "icon/redGreenScooter")
        XCTAssert(sVM5.vehicleImageName == "icon/scooter")
    }
    
    func testFilterInVehicleCellVM() {
        
        let sVM11 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "11")
        let sVM12 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "12")
        let sVM13 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "13")

        let sVM21 = VehicleCellVM(color: "YellowBlue", qrURL: "", identificationCode: "21")
        let sVM22 = VehicleCellVM(color: "YellowBlue", qrURL: "", identificationCode: "22")

        let sVM31 = VehicleCellVM(color: "PinkYellow", qrURL: "", identificationCode: "31")
        let sVM32 = VehicleCellVM(color: "PinkYellow", qrURL: "", identificationCode: "32")
        let sVM33 = VehicleCellVM(color: "PinkYellow", qrURL: "", identificationCode: "33")
        let sVM34 = VehicleCellVM(color: "PinkYellow", qrURL: "", identificationCode: "34")

        let sVM41 = VehicleCellVM(color: "RedGreen", qrURL: "", identificationCode: "41")
        
        let arr = [sVM11, sVM12, sVM13, sVM21, sVM22, sVM31, sVM32, sVM33, sVM34, sVM41]
        
        let n1 = VehicleCellVM.filter(vehicles: arr, with: ["BlueRed", "YellowBlue", "PinkYellow", "RedGreen"], totalNumberOfFilters: 4)
        
        let n2 = VehicleCellVM.filter(vehicles: arr, with: ["BlueRed"], totalNumberOfFilters: 4)
        let n3 = VehicleCellVM.filter(vehicles: arr, with: ["BlueRed", "PinkYellow"], totalNumberOfFilters: 4)

        let n4 = VehicleCellVM.filter(vehicles: arr, with: ["BlueRed", "PinkYellow", "RedGreen"], totalNumberOfFilters: 4)

        XCTAssert(n1 == nil)
        XCTAssert(n2!.count == 3)
        XCTAssert(n3!.count == 7)
        XCTAssert(n4!.count == 8)
    }
    
    // VehicleVM
    func testVehicleVM() {
        let vcVM1 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "QPX-CSL")
        let vcVM2 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "")
        let vcVM3 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "123")

        let vVM1 = VehicleVM(vehicleCellVM: vcVM1)
        let vVM2 = VehicleVM(vehicleCellVM: vcVM2)
        let vVM3 = VehicleVM(vehicleCellVM: vcVM3)
        
        XCTAssert(vVM1.title == "Scooter code: \(vcVM1.identificationCode)")
        XCTAssert(vVM2.title == "No code!!!")
        XCTAssert(vVM3.title == "Scooter code: \(vcVM3.identificationCode)")
    }
    
    // FiltersVM
    func testInitWithFilteredVehicles() {
        
        let colorFilteringArray1 = ["BlueRed", "YellowBlue", "RedGreen", "PinkYellow"]
        let colorFilteringArray2 = ["BlueRed", "YellowBlue", "RedGreen"]
        let colorFilteringArray3 = ["BlueRed", "YellowBlue"]
        let colorFilteringArray4 = ["YellowBlue"]

        let fVM0 = FiltersVM(filteringStringArray: colorFilteringArray1)
        let fVM1 = FiltersVM(filteringStringArray: colorFilteringArray2)
        let fVM2 = FiltersVM(filteringStringArray: colorFilteringArray3)
        let fVM3 = FiltersVM(filteringStringArray: colorFilteringArray4)
        
        XCTAssert(fVM0.isBlueRedSwitchOn == true)
        XCTAssert(fVM0.isRedGreenSwitchOn == true)
        XCTAssert(fVM0.isYellowBlueSwitchOn == true)
        XCTAssert(fVM0.isPinkYellowSwitchOn == true)
        
        XCTAssert(fVM1.isBlueRedSwitchOn == true)
        XCTAssert(fVM1.isRedGreenSwitchOn == true)
        XCTAssert(fVM1.isYellowBlueSwitchOn == true)
        XCTAssert(fVM1.isPinkYellowSwitchOn == false)
        
        XCTAssert(fVM2.isBlueRedSwitchOn == true)
        XCTAssert(fVM2.isRedGreenSwitchOn == false)
        XCTAssert(fVM2.isYellowBlueSwitchOn == true)
        XCTAssert(fVM2.isPinkYellowSwitchOn == false)
        
        XCTAssert(fVM3.isBlueRedSwitchOn == false)
        XCTAssert(fVM3.isRedGreenSwitchOn == false)
        XCTAssert(fVM3.isYellowBlueSwitchOn == true)
        XCTAssert(fVM3.isPinkYellowSwitchOn == false)
    }
    
    func testInitWithFilteringStringArray() {
        
        let vcVM1 = VehicleCellVM(color: "BlueRed", qrURL: "", identificationCode: "11")
        let vcVM2 = VehicleCellVM(color: "YellowBlue", qrURL: "", identificationCode: "21")
        let vcVM3 = VehicleCellVM(color: "PinkYellow", qrURL: "", identificationCode: "31")
        let vcVM4 = VehicleCellVM(color: "RedGreen", qrURL: "", identificationCode: "41")
        
        let arr1 = [vcVM1, vcVM2, vcVM3, vcVM4]
        let arr2 = [vcVM1, vcVM2]
        let arr3 = [vcVM3, vcVM4]
        let arr4 = [vcVM4]
        
        let fVM0 = FiltersVM(filteredVehicles: nil)
        let fVM1 = FiltersVM(filteredVehicles: arr1)
        let fVM2 = FiltersVM(filteredVehicles: arr2)
        let fVM3 = FiltersVM(filteredVehicles: arr3)
        let fVM4 = FiltersVM(filteredVehicles: arr4)

        XCTAssert(fVM0.isBlueRedSwitchOn == true)
        XCTAssert(fVM0.isRedGreenSwitchOn == true)
        XCTAssert(fVM0.isYellowBlueSwitchOn == true)
        XCTAssert(fVM0.isPinkYellowSwitchOn == true)

        XCTAssert(fVM1.isBlueRedSwitchOn == true)
        XCTAssert(fVM1.isRedGreenSwitchOn == true)
        XCTAssert(fVM1.isYellowBlueSwitchOn == true)
        XCTAssert(fVM1.isPinkYellowSwitchOn == true)
        
        XCTAssert(fVM2.isBlueRedSwitchOn == true)
        XCTAssert(fVM2.isRedGreenSwitchOn == false)
        XCTAssert(fVM2.isYellowBlueSwitchOn == true)
        XCTAssert(fVM2.isPinkYellowSwitchOn == false)
        
        XCTAssert(fVM3.isBlueRedSwitchOn == false)
        XCTAssert(fVM3.isRedGreenSwitchOn == true)
        XCTAssert(fVM3.isYellowBlueSwitchOn == false)
        XCTAssert(fVM3.isPinkYellowSwitchOn == true)
        
        XCTAssert(fVM4.isBlueRedSwitchOn == false)
        XCTAssert(fVM4.isRedGreenSwitchOn == true)
        XCTAssert(fVM4.isYellowBlueSwitchOn == false)
        XCTAssert(fVM4.isPinkYellowSwitchOn == false)
    }
}
