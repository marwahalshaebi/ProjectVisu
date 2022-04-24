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
    // this state object is incharge of passing user informtation around views
    @StateObject var session = SessionProtocolImplementation()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                // Implemented keeping track of user's log in state
                switch session.state {
                case .loggedOut:
                    GetStartedView()
                        .environmentObject(session)
                case .loggedIn:
                    WelcomeView()
                        .environmentObject(session)
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
