//
//  PinDigitsView.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/8/21.
//
import SwiftUI

struct PasscodeField: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var loginVM: LoginViewModel
    
    @State private var label = "Новый пин?"
    @State private var isDisabled = false
    @State private var pin: String = ""
    
    @State  var isChangePin: Bool
    @State private var newPass = ""
    @State private var isShowingAlert = false
    @State private var messageAlert = ""
    @State private var titleAlert = ""
    
    var maxDigits: Int = 4
    
    public var body: some View {
        ZStack {
            CustomBackground()
            VStack( spacing: 15) {
                Spacer()
                
                if isChangePin {
                    Text (label)
                        .font(.system(size: 25, weight: .medium))
                }
                
                ZStack {
                    pinDots
                    backgroundField
                }
                Spacer()
                padView
                    .padding(20)
                
            }
            .navigationTitle( isChangePin ? Text("Сброс пина") : Text("Доказательства?"))
        }
    }
    
    private var pinDots: some View {
        HStack (spacing: 20) {
            ForEach(0 ..< maxDigits) { index in
                Image(systemName: self.getImageName(at: index))
                    .font(.system(size: 25, weight: .thin, design: .default))
                    
            }
        }
    }
    
    private var backgroundField: some View {
        TextField("", text: $pin)
           .accentColor(.clear)
           .foregroundColor(.clear)
           .disabled(isDisabled)
    }
    
    private var padView : some View {
        
        ZStack {
                GridStack(rows: 4, colomns: 3) { row, col in
                    
                    VStack {
                        switch (row * 3 + col + 1) {
                        case 10:  Circle().hidden()
                        case 11:
                            Button {
                                tapNumber(with: 0)
                            } label: {
                                ZStack {
                                Circle().fill(.gray).opacity(0.2)
                                Text("0").font(.largeTitle)
                            }
                            }

                        case 12:
                            Button {
                                if (!pin.isEmpty) { pin.removeLast() }
                            } label: {
                                ZStack {
                                    Circle().hidden()
                                    Image(systemName: "delete.left").resizable().frame(width: 25, height: 20)
                                }
                            }

                        default:
                            Button {
                                tapNumber(with: row * 3 + col + 1)
                            } label: {
                                ZStack {
                                    Circle().fill(.gray).opacity(0.2)
                                    Text("\(row * 3 + col + 1)").font(.largeTitle)
                                }
                            }

                           
                        }
                    } .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text(titleAlert),
                              message: Text(messageAlert),
                              dismissButton: .default(Text("Ok"),
                                                      action: {
                        }))
                    }
                   
                }.foregroundColor(colorScheme == .dark ? .gray : .black )
                .frame(width: UIScreen.main.bounds.width - 100,
                       height: UIScreen.main.bounds.height / 2,
                       alignment: .center)
                
        }
        
    }
    
    struct GridStack <Content: View> : View {
        let rows: Int
        let colomns: Int
        let content: (Int, Int) -> Content
        
        var body: some View {
            VStack( alignment: .leading) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< colomns, id: \.self) { col in self.content(row,col)
                            
                        }
                    }
                    
                }
            }
        }
    }

    private func tapNumber (with number: Int) {
        pin = pin + "\(number)"
        if pin.count == maxDigits {
            print(loginVM.credentials.coachId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isDisabled = true
                loginVM.credentials.pin = pin
                isChangePin ? changePin() : sendPin()
            }
        }
    }
    
    private func sendPin () {
       print(pin)
        if pin == "1234" {
            auth.updateValidation(with: true)
        } else {
            auth.updateValidation(with: false)
        }
        pin = ""
        isDisabled = false
                       
    }
    
    private func changePin () {
        /*
        if newPass.isEmpty, !pin.isEmpty {
                              newPass = pin
                              print(newPass)
                              pin = ""
                              isDisabled = false
                              label = "Еще раз!"
                          } else {
                              if newPass == pin {
                                  NetworkManager.shared.requestChangePass(pin: pin, userId: loginVM.credentials.coachId)
                                  newPass = ""
                                  pin = ""
                                  
                                  isShowingAlert = true
                                  titleAlert = "Пароли совпали!"
                                  messageAlert = "Пароль изменен"
                                  label = ""
                                  print("Совпадение и выход!")
                                  presentationMode.wrappedValue.dismiss()
                                  
                              } else {
                                  newPass = ""
                                  pin = ""
                                  isDisabled = false
                                  isShowingAlert = true
                                  titleAlert = "Пины не совпали"
                                  messageAlert = "Давай еще раз"
                                  label = "Новый пин?"
                                  print ("Пароли не совпадают, начинаем заново")
      
                              }
      
                          }
         */
    }
    
    private func getImageName(at index: Int) -> String {
        if index >=  pin.count {
            return "circle"
        }
        return "circle.fill"
    }
}

struct PasscodeField_Preview: PreviewProvider {
    static var previews: some View {
        PasscodeField(isChangePin: true)
    }
}
