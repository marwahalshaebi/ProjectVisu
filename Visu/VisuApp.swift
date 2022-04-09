//
//  VisuApp.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-02-23.
//

import SwiftUI
import Firebase

@main
struct VisuApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var sessionProtocol = SessionProtocolImplementation()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                
                switch sessionProtocol.state {
                case .loggedOut:
                    PlayTrackView()
                        .environmentObject(sessionProtocol)
                case .loggedIn:
                    PlayTrackView()
                }
            }
            
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
