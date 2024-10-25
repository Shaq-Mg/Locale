//
//  LocaleApp.swift
//  Locale
//
//  Created by Shaquille McGregor on 04/09/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct LocaleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var locationVM = LocationSearchViewModel()
    @StateObject private var mainMessagesVM = MainMessagesViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(authVM)
                    .environmentObject(locationVM)
                    .environmentObject(mainMessagesVM)
            }
        }
    }
}
