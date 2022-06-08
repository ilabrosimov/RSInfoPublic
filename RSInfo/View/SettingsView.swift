//
//  SettingsView.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/28/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                CustomBackground()
                VStack {
                    
                    List {
                        NavigationLink("Сменить пин") {
                            PasscodeField(isChangePin: true)
                        }.listRowBackground(Color.clear)
                        Button {
                            loginVM.credentials = Credentials()
                            print(loginVM.credentials)
                            auth.updateValidation(with: false)
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Text("Выйти")
                        }.listRowBackground(Color.clear)
                    }
                }.navigationTitle("Настройки")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Capsule()
                          .fill(Color.secondary)
                          .frame(width: 30, height: 3)
                          .padding(10)

                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
