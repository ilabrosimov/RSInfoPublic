//
//  RSInfoApp.swift
//  RSInfo
//
//  Created by ilabrosimov on 02.08.2021.
//

import SwiftUI

@main
struct RSInfoApp: App {
    @StateObject var auth = Auth()
    @StateObject var loginVM = LoginViewModel()
    @StateObject var dataModel = DataModel()
    
    var body: some Scene {
        WindowGroup {
            if (auth.isValidated) {
                CourseView()
                    .environmentObject(auth)
                    .environmentObject(loginVM)
                    .environmentObject(dataModel)
            }else {
                LoginView()
                    .environmentObject(auth)
                    .environmentObject(loginVM)
                    .environmentObject(dataModel)
                
            }
           
            
        }
    }
}
