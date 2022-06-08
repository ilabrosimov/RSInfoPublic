//
//  InstructorList.swift
//  RSInfo
//
//  Created by ilabrosimov on 10/25/21.
//

import SwiftUI

struct InstructorList: View{
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var dataModel: DataModel
    
    
    
    @State private var isShowingProgress = false
    @State private var isShowingAlert = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State var selectedGear: Gear
    
    var body: some View  {
        
        VStack {
            if isShowingProgress {
                ProgressView().padding()
            }
            List  {
                ForEach (dataModel.lectors.sorted(by: < )) { lector in
                    Button (action: {
                        loginVM.credentials.coachId = lector.id
                        
                    }, label: {
                        Text(lector.name)
                    })
                }.listRowBackground(Color.clear)
            }.onAppear (perform: fetchLectors)
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                }
        }
        
    }
    
    private func fetchLectors () {
        dataModel.lectors = [Lector(id: "1", name: "Первый лектор"),
                            Lector(id: "2", name: "Второй лектор"),
                             Lector(id: "3", name: "Третий лектор")]
        
        /* isShowingProgress = true
        NetworkManager.shared.fetchData(id: selectedGear.rawValue) {  (lectors: [Lector]) in
            DispatchQueue.main.async{
                if !lectors.isEmpty {
                    dataModel.lectors = lectors
                } else
                {
                  alertTitle = "Нет соединения"
                  alertMessage = "Проверьте интернет"
                  isShowingAlert = true
                }
                isShowingProgress = false

            }
        }*/
    }
}
//struct InstructorList_Previews: PreviewProvider {
//    static var previews: some View {
//        InstructorList()
//    }
//}
