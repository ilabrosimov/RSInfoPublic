//
//  CourseMainView.swift
//  RSInfo
//
//  Created by ilabrosimov on 03.08.2021.
//

import SwiftUI

struct CourseView: View {
    
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var dataModel: DataModel
    
    
    @State private var isShowingProgress = false
    @State private var isShowingAlert = false
    @State private var isShowingSettings = false
    @State private var isShowingStudents = false
    
    
    @State private var selectedCourse: Course?
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                CustomBackground()
                VStack {
                    
                    if isShowingProgress {
                        ProgressView()
                    } else {
                        List (dataModel.courses.sorted(by: < )) { course in
                            ZStack {
                                NavigationLink {
                                    StudentView(course: course)
                                    
                                } label: {}
                                ZStack {
                                    CourseViewCell(course: course)
                                    if course.isActual {
                                        Capsule().strokeBorder(Color.black, lineWidth: 1.5)
                                    }
                                }
                            }.listRowBackground(Color.clear)
                        }
                    }
                    
                }
                    .toolbar {
                        ToolbarItem( placement: .navigationBarLeading) {
                            Button(action: {
                                isShowingSettings = true
                            }, label: {
                                Image(systemName: "gear")
                            })
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Обновить") {
                                isShowingProgress = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    fetchCourses()
                                    isShowingProgress = false
                                }
                              
                            }
                        }
                    }
                    .sheet (isPresented: $isShowingSettings) {
                        SettingsView()
                    }.alert(isPresented: $isShowingAlert, content: {
                        Alert(title: Text("Доступных курсов нет"), message: Text("Попробуй позже"), dismissButton: .cancel())
                    })
                    .navigationTitle(Text("Курсы"))
                    .onAppear {
                        isShowingProgress = true
                        fetchCourses()
                    }
            }
        }
    }
    private func fetchCourses () {
        NetworkManager.shared.fetchData(id: "0") {  (courses: [Course]) in
            DispatchQueue.main.async {
                dataModel.courses = [Course(id: "1", date: "01-01-2023", coursetype: "2", cancelled: "0",                           coursename: "Pro", level: "", days: "3", isspecial: "0", bgcolor:                           "f2cda2ff", numstudents: "2"),
                                     Course(id: "2", date: "02-01-2023", coursetype: "1", cancelled: "0", coursename: "Freeride", level: "", days: "5", isspecial: "1", bgcolor: "FFFF00ff", numstudents: "2"),
                                     Course(id: "3", date: "03-01-2023", coursetype: "3", cancelled: "0", coursename: "Park", level: "", days: "4", isspecial: "1", bgcolor: "accbffff", numstudents: "2")]
                if !courses.isEmpty {
                    //Курсы из сети передаем в модель
                } else {
                    /*
                    if let savedData = UserDefaults.standard.data(forKey: "Courses") {
                        if let jsonData = try? JSONDecoder().decode([Course].self, from: savedData) {
                            dataModel.courses = jsonData
                        }
                    
                    }
//                 isShowingAlert = true */
                }
                isShowingProgress = false
            }
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView().environmentObject(LoginViewModel())
                    .environmentObject(DataModel())
    }
}
