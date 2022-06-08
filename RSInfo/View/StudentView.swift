//
//  AddLectorView.swift
//  RSInfo
//
//  Created by ilabrosimov on 02.08.2021.
//

import SwiftUI

struct StudentView: View {
    @EnvironmentObject var dataModel: DataModel
    
    @State var course: Course
    @State var isConfirm = false
    @State private var showingProgress = false
    
    var body: some View {
        
        ZStack {
            CustomBackground()
            VStack {
                Text(course.courseFullName)
                    .font(.title)
                    .padding(.horizontal, UIScreen.main.bounds.width/4)
                    .background(Color(UIColor("#\(course.bgcolor)") ?? UIColor.white))
                    .clipShape(Capsule())
                    .padding(.vertical, 10)
                
                if (showingProgress) {
                    ProgressView()
                }
                ScrollView {
                    if (!dataModel.students.isEmpty) {
                        ForEach(0 ..< dataModel.students.count) {
//                          StudentViewCell(number: $0 + 1, student: students[$0], disabled: false)
//                            let student = students[$0]
//                            let number = $0
                            if (dataModel.students[$0].cancelled == "0") {
                                StudentViewCell(number: $0 + 1, student: dataModel.students[$0], disabled: false)
                            } else {
                                StudentViewCell(number: $0 + 1, student: dataModel.students[$0], disabled: true).padding(.leading, 20)
                            }
                            Divider()
                        }
                    }
                }.padding(.all, 20)
                    .navigationTitle(course.dateFormatted)
            }
            .onAppear() {
                showingProgress = true
                fetchStudents()
            }
        }
    }
    
   
    private func fetchStudents () {
        NetworkManager.shared.fetchData(id: "0") {  (students: [Student]) in
            DispatchQueue.main.async {
                
                dataModel.students = [Student(id: "1", studentid: "1", name: "Первый студент", phone:                           "89999999999", isapproved: "1", ispaid: "1", isconfirmed: "0", iscalled:                    "0", cancelled: "0", comment: "Первый раз, никогда не катался"),
                                      Student(id: "2", studentid: "2", name: "Второй студент", phone: "88888888888", isapproved: "0", ispaid: "0", isconfirmed: "0", iscalled: "0", cancelled: "0", comment: "Уже у вас был"),
                                        Student(id: "3", studentid: "3", name: "Третий студент", phone: "87777777777", isapproved: "0", ispaid: "1", isconfirmed: "0", iscalled: "1", cancelled: "1", comment: "Не могу приехать")]
                
                if !students.isEmpty {
                    /*
                    dataModel.students  = students.filter{ $0.cancelled == "0"}
                    let cancelledStudents = students.filter {$0.cancelled == "1"}
                    dataModel.students += cancelledStudents
                     */
                    
                } else {
                    /*
                    if let savedData = UserDefaults.standard.data(forKey: "Students") {
                        if let jsonData = try? JSONDecoder().decode([Student].self, from: savedData) {
                            dataModel.students = jsonData
                        }
                    }
                    */
                }
                
                showingProgress = false
            }
        }
    }
}

//struct CourseDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        StudentView(course: Course(id: "172", date: "11-01-2021", coursetype: "7", cancelled: "0", coursename: "SB", level: "Green", days: "4", isspecial: "0", bgcolor: "dce9d5ff", numstudents: "4"))
//    }
//}

