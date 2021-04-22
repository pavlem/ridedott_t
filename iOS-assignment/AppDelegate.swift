//
//  AppDelegate.swift
//  iOS-assignment
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()

        return true
    }
    
    // MARK: - Helper
    private func setRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: VehiclesViewController())
        window?.makeKeyAndVisible()
    }
}
