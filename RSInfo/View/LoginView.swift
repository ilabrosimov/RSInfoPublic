

//
//  LectorView.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/7/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    @State private var selectedGear: Gear = .sb
    
    init() {
       
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
        UISegmentedControl.appearance().selectedSegmentTintColor = .secondarySystemBackground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
      }
    
    var body: some View {
        
        NavigationView {
            ZStack {
               CustomBackground()
                VStack {
                          if (loginVM.credentials.coachId.isEmpty) {
                              Picker("Choose a Side", selection: $selectedGear) {
                                  ForEach (Gear.allCases, id: \.self) {
                                      Text($0.rawValue.uppercased()).font(.title)
                                  }
                                  
                              }   .pickerStyle(SegmentedPickerStyle())
                                  .padding(.top, 30)
                                  .padding(.horizontal)
                              
                               ChosenInstructor(gear: $selectedGear)
                                  
                          } else {
                              pinView
                          }
                      }
                          .navigationTitle("Выбери сторону")
            }
      
                
        }
    }
    
    struct ChosenInstructor: View {
        @Binding var gear: Gear
        var body: some View {
            switch gear {
            case .sb:
                InstructorList( selectedGear: .sb)
            case .ski:
                InstructorList( selectedGear: .ski)
            }
        }
    }
    
    
    private var pinView: some View {
         VStack {
             PasscodeField (isChangePin: false)
                 .toolbar {
                ToolbarItem ( placement: .navigationBarLeading){
                    Button(action: {loginVM.credentials = Credentials()}, label: {
                        Image(systemName: "chevron.backward")
                    Text("Вернуться")
                })
                }
            }
        }
    }
}

struct LectorView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(LoginViewModel())
            .preferredColorScheme(.light)
            
    }
}

