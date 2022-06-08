//
//  Auth.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/11/21.
//

import SwiftUI

class Auth: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(with success: Bool )  {
        withAnimation {
            isValidated = success
        }
        
    }
}
