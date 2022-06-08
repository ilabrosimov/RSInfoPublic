////
////  LectorList.swift
////  RSInfo
////
////  Created by ilabrosimov on 9/12/21.
////
//
//import SwiftUI
//
//struct LectList: View {
//    @State var selectedGear: Gear = .sb
//
//
//
//    var body: some View {
//        VStack {
//
//            Picker("Choose a Side", selection: $selectedGear) {
//                ForEach (Gear.allCases, id: \.self) {
//                    Text($0.rawValue.uppercased())
//                }
//            } .pickerStyle(SegmentedPickerStyle()).padding()
//
//            if  (selectedGear ==  .sb) {
//                InstructorList(selectedGear: .sb)
//            } else {
//                InstructorList(selectedGear: .ski)
//            }
//        }
//    }
//}
//struct ChoosenGear: View {
//   @Binding var selectedGear: Gear
//    var body: some View {
//        switch selectedGear {
//        case .sb:
//            InstructorList(selectedGear: .sb)
//        case .ski:
//            InstructorList(selectedGear: .ski)
//
//        }
//    }
//}
//struct InstructorList: View{
//    var selectedGear: Gear
//    @State  var lectors = [Lector]()
//    var body: some View  {
//        List(lectors.sorted(by: < )) { lector in
//            Button (action: {
//                //loginVM.credentials.coachId = lector.id
//            }, label: {
//                Text(lector.name)
//            })
//        }.onAppear()  {
//            NetworkManager.shared.getLectors(gear: selectedGear.rawValue) { lectors in
//                                                self.lectors = lectors
//                                                }
//        }
//    }
//}
//
//struct LectorList_Previews: PreviewProvider {
//    static var previews: some View {
//        LectList().environmentObject(LoginViewModel())
//    }
//}
