//
//  LoginViewModel.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/11/21.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var credentials = Credentials()
    @Published var showingProgress = false
    var loginIsDisabled: Bool {
        return credentials.coachId.isEmpty || credentials.pin.isEmpty
    }
    

    
    func login (completion: @escaping (Bool)  ->  Void) {
        NetworkManager.shared.APIAuthRequest(credentials: credentials) { success in
             completion(success)
        }
    }
 
}
