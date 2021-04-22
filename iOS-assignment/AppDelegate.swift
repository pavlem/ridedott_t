//
//  AppDelegate.swift
//  iOS-assignment
//

import UIKit

import RxRelay
import AssignmentUtility
import AssignmentUtility.Swift
import Foundation
import RxSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        
        
        let ooo = AssignmentUtility.requestVehiclesData()
        
        ooo.subscribe { result in
            
            switch result {
            
            case .next(let data):
                
                do {
                    
                    let scooters = try JSONDecoder().decode(ScooterDictionary.self, from: data)
                    print(scooters)
                    
                    
                    // make sure this JSON is in the format we expect
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        // try to read out a string array
//
//                        print(json)
//                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
//            print(data)
            case .error(let err):
            print(err)
            case .completed:
                print(".completed")
            }
        }
        print("")

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


//["vehicles":
struct ScooterDictionary: Decodable {
    let vehicles: [Scooter]
    
    struct Scooter: Decodable {
        var color: String
        var qrURL: String
        var identificationCode: String
    }
}



//
//▿ 3 : 3 elements
//  ▿ 0 : 2 elements
//    - key : color
//    - value : YellowBlue
//  ▿ 1 : 2 elements
//    - key : qrURL
//    - value : https://user-images.githubusercontent.com/4403840/99518015-54d1d800-2990-11eb-84a2-0ad4a3bf6a54.png
//  ▿ 2 : 2 elements
//    - key : identificationCode
//    - value : QWP-CSL
