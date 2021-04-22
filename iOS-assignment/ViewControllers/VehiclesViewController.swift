//
//  VehiclesViewController.swift
//  iOS-assignment
//
//  Created by Pavle Mijatovic on 22.4.21..
//

import UIKit
import AssignmentUtility
import AssignmentUtility.Swift
import RxSwift

class VehiclesViewController: UIViewController {

    // MARK: - Properties
    private var vehicles = [VehicleCellVM]() {
        didSet {
            DispatchQueue.main.async {
                self.fleetTableView.reloadData()
            }
        }
    }
    
    private var vehiclesFiltered: [VehicleCellVM]? {
        didSet {
            DispatchQueue.main.async {
                self.fleetTableView.reloadData()
            }
        }
    }
    
    private var vehiclesVM = VehiclesVM() {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    private var colorsFilter: [String]? {
        return UserDefaultsHelper.shared.colorsFilter
    }
    
    private var isFiltering: Bool {
        return vehiclesFiltered != nil
    }
    
    private var subscription: Disposable?
    private let bag = DisposeBag()
    
    private var isChildViewControllerUp: Bool {
        return bottomCsrt.constant != 0
    }
    
    @IBOutlet weak var bottomCsrt: NSLayoutConstraint!
    @IBOutlet weak var fleetOverviewLbl: HeroLabel!
    @IBOutlet weak var filterBtn: FilterButton!
    @IBOutlet weak var fleetTableView: DottTableView!
    @IBOutlet weak var childFilterScreen: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegates()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        subscription?.disposed(by: bag)
    }
    
    // MARK: - Helper
    private func handle(vehicles: [Vehicle]) {
        self.vehicles = vehicles.map { VehicleCellVM(vehicle: $0) }
        
        if let colorsFilter = colorsFilter {
            vehiclesFiltered = VehicleCellVM.filter(vehicles: self.vehicles, with: colorsFilter, totalNumberOfFilters: FiltersVehicleType.colorFilters.count)
        }
        
        self.vehiclesVM = VehiclesVM(isFetchingInProgress: false, isFilterActive: self.isFiltering)
    }
    
    private func fetchData() {
        
        let observable = AssignmentUtility.requestVehiclesData()
        
        subscription = observable.subscribe { result in
            
            switch result {
            
            case .next(let data):
                do {
                    let vehicleDict = try JSONDecoder().decode(VehicleDictionary.self, from: data)
                    self.handle(vehicles: vehicleDict.vehicles)
                } catch let err {
                    AlertHelper.simpleAlert(message: err.localizedDescription, vc: self) {}                }
            
            case .error(_):
                
                AlertHelper.simpleAlert(message: self.vehiclesVM.somethingWentWrongMessage, vc: self) {
                    self.vehiclesVM = VehiclesVM(isFetchingInProgress: true, isFilterActive: self.isFiltering)
                    self.fetchData()
                }
                
            case .completed:
                break
            }
        }
    }
    
    private func setDelegates() {
        fleetTableView.delegate = self
        fleetTableView.dataSource = self
    }
    
    private func setUI() {
        navigationController?.isNavigationBarHidden = true
        bottomCsrt.constant = -childFilterScreen.frame.height
        
        vehiclesVM.isFetchingInProgress ? BlockingScreen.start(vc: self) : BlockingScreen.stop()
        let nib = UINib(nibName: VehicleCell.cellNibName, bundle: nil)
        fleetTableView.register(nib, forCellReuseIdentifier: VehicleCell.cellId)
        filterBtn.isFilterActive = vehiclesVM.isFilterActive
    }
    
    private func updateUI() {
        vehiclesVM.isFetchingInProgress ? BlockingScreen.start(vc: self) : BlockingScreen.stop()
        filterBtn.isFilterActive = vehiclesVM.isFilterActive
    }
    
    private func raiseChildVC() {
        self.bottomCsrt.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func closeChildVC() {
        bottomCsrt.constant = -childFilterScreen.frame.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { (isFinished) in
            if isFinished {
                for view in self.childFilterScreen.subviews {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func filter(_ sender: FilterButton) {
        
        let filtersVC = FiltersViewController()
        if isFiltering {
            filtersVC.vm = FiltersVM(filteredVehicles: vehiclesFiltered)
        }
        
        filtersVC.getColorFilters = { colorStrings in
            self.closeChildVC()
            
            guard colorStrings.count < FiltersVehicleType.colorFilters.count else {
                self.vehiclesFiltered = nil
                self.vehiclesVM = VehiclesVM(isFetchingInProgress: false, isFilterActive: false)
                return
            }
            self.vehiclesFiltered = VehicleCellVM.filter(vehicles: self.vehicles, with: colorStrings, totalNumberOfFilters: FiltersVehicleType.colorFilters.count)
            self.vehiclesVM = VehiclesVM(isFetchingInProgress: false, isFilterActive: true)
        }
        
        filtersVC.closeColorFilter = {
            self.closeChildVC()
        }
        
        childFilterScreen.add(childVC: filtersVC, toParrentVC: self)
        raiseChildVC()
        
    }
}

// MARK: - UITableViewDelegate
extension VehiclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vehicleVC = VehicleViewController()
        if isFiltering {
            guard let vehiclesFiltered = vehiclesFiltered else { return }
            vehicleVC.vm = VehicleVM(vehicleCellVM: vehiclesFiltered[indexPath.row])
        } else {
            vehicleVC.vm = VehicleVM(vehicleCellVM: vehicles[indexPath.row])
        }
        
        vehicleVC.closeColorFilter = {
            self.closeChildVC()
        }
        
        childFilterScreen.add(childVC: vehicleVC, toParrentVC: self)
        
        guard isChildViewControllerUp else { return }
        raiseChildVC()
    }
}

// MARK: - UITableViewDataSource
extension VehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return vehiclesFiltered?.count ?? 0
        } else {
            return vehicles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.cellId) as? VehicleCell else {
            return UITableViewCell()
        }
        cell.vm = vehicles[indexPath.row]
        
        if isFiltering {
            cell.vm = vehiclesFiltered?[indexPath.row]
        } else {
            cell.vm = vehicles[indexPath.row]
        }
        
        return cell
    }
}

extension UIView {
    func add(childVC: UIViewController, toParrentVC parrentVC: UIViewController) {
        parrentVC.addChild(childVC)
        childVC.view.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        if self.subviews.count > 0 {
            for view in self.subviews {
                view.removeFromSuperview()
            }
        }
        
        self.addSubview(childVC.view)
        childVC.didMove(toParent: parrentVC)
        
    }
}
