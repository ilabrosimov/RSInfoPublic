//
//  CourseManager.swift
//  RSInfo
//
//  Created by ilabrosimov on 02.08.2021.
//

import Foundation
class CourseManager {
    static let shared = CourseManager()
    private init () {}
    
    func makeCourse() -> [Course] {
        let lector = Lector(name: "Илья", lastName: "Абросимов")
        let students = [Student(name: "Ирина Козина", phone: "+79384501122"),
                        Student(name: "Анатон Голошников", phone: "+79384501122"),
                        Student(name: "Петр Великий", phone: "+79384501122"),
                        Student(name: "Зануда Богатый", phone: "+79384501122"),
                        Student(name: "Фрирайдер Скоростной", phone: "+79384501122"),
                        Student(name: "Мозговитый Фристайлер", phone: "+79384501122")
        ]
        
        let courses  = [ Course(name: "Новички", sport: .snowboard, lector: lector , students: students, startDate: Date(), endDate: Date() + 86400),
                         Course(name: "Умеющие", sport: .snowboard, lector: lector , students: students, startDate: Date(), endDate: Date() + 86400),
                         Course(name: "ПРО", sport: .snowboard, lector: lector , students: students, startDate: Date(), endDate: Date() + 86400),
        ]
        return courses
        
    }
}
