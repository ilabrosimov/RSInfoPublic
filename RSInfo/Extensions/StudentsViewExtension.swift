//
//  PhoneCall.swift
//  RSInfo
//
//  Created by ilabrosimov on 02.08.2021.
//

import SwiftUI

extension StudentViewCell {
    
    func dialNumber(number : String) {
        var phoneNumber = ""
        for char in number {
            char.isWhitespace ? print("whiteSpace"): phoneNumber.append(char)
        }
        print(number)
        guard let urlNumber = URL(string: "tel://\(phoneNumber)") else { return }
        UIApplication.shared.open(urlNumber)
    }
}

