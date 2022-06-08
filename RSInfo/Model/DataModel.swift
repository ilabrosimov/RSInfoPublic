//
//  DataModel.swift
//  RSInfo
//
//  Created by ilabrosimov on 11/9/21.
//

import Foundation
class DataModel: ObservableObject {
    @Published var lectors =  [Lector]()
    @Published var courses = [Course](){
        didSet {
            if let savedCourses = try? JSONEncoder().encode(courses) {
                UserDefaults.standard.set(savedCourses, forKey: "Courses")
            }
        }
    }
    @Published var students = [Student]()
    {
        didSet {
            if let savedStudents = try? JSONEncoder().encode(students) {
                UserDefaults.standard.set(savedStudents, forKey: "Students")
            }
        }
    }
    
}
