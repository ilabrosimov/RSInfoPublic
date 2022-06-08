//
//  SegmentedPicker.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/12/21.
//

import SwiftUI

struct SegmentedPicker: View {
    @State private var selectedSide: SideOfTheForce = .light
    init() {
            UISegmentedControl.appearance().selectedSegmentTintColor = .yellow
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
        }
    var body: some View {
        
        Picker("Choose a Side", selection: $selectedSide) {
                               ForEach(SideOfTheForce.allCases, id: \.self) {
                                   Text($0.rawValue)
                               }
                           }.pickerStyle(SegmentedPickerStyle())
                           .padding()
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker()
    }
}
