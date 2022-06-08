//
//  StudentViewCell.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/12/21.
//

import SwiftUI

struct StudentViewCell: View {
    
    @State var number: Int
    @State var student: Student
    @State var disabled: Bool
    
    var body: some View {
        
        VStack  {
           
                HStack {
                    if !disabled { Text ("\(number).") }
                    VStack (alignment: .leading) {
                        dialNumberButton
                        if !student.comment.isEmpty {
                            commentText.padding(.leading, 1)
                        }
                    }
                    
                    Spacer()
                    if (disabled) {
                        Text("отмена").foregroundColor(.red)
                    }
                    Spacer()
                    student.ispaid == "1" ? Text("₽") : Text("")
                    ZStack {

                        Circle().stroke()
                        if (student.selectedConfirmation == true ) {
                            Image(systemName: "checkmark").foregroundColor(.green)
                        }
                        
                    }.frame(width: 40, height: 20)
                    .onTapGesture {
                        if (!disabled) {
                            student.selectedConfirmation?.toggle()
                            /* NetworkManager.shared.postRequest(studentId: student.studentid, confirmation:  student.selectedConfirmation ?? false) */
                        }
                    }
                }
           
        } .padding(.vertical, 3)
        .onAppear {
            if  (student.selectedConfirmation == nil) {
                student.selectedConfirmation = student.isConfirmed
            }
        }
    }
    
    
    private var dialNumberButton: some View {
        Button(action: {
            if (!disabled) {
                dialNumber(number: student.phone)
            }
            
        }, label: {
            Text(student.name)
                .foregroundColor(disabled ? Color.gray : Color.primary)
                .fontWeight(.medium)
        }).disabled(disabled)
    }
    
    private var commentText: some View {
        Text(student.comment)
            .fontWeight(.thin)
            .font(.subheadline)
    }
}

struct StudentViewCell_Previews: PreviewProvider {
    static var previews: some View {
        StudentViewCell(number: 1, student: Student(id: "0", studentid: "81", name: "Игорь Иванов", phone: "+79147169702", isapproved: "1", ispaid: "1", isconfirmed: "1", iscalled: "0", cancelled: "1", comment: "Болят колени"),disabled: false)
    }
}
