//
//  jsonModel.swift
//  JsonApp
//
//  Created by ilabrosimov on 18.08.2021.
//


import Foundation

enum Gear : String, CaseIterable, Equatable {
    case sb = "sb"
    case ski = "as"
    
}
// MARK: - Lector
struct Lector: Codable, Identifiable, Comparable {
    static func < (lhs: Lector, rhs: Lector) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: String
    let name: String
   
}

// MARK: - Course
struct Course: Codable, Identifiable, Comparable {
//    static func == (lhs: Course, rhs: Course) -> Bool {
//        lhs.dateStart == rhs.dateStart
//    }
    
    static func < (lhs: Course, rhs: Course) -> Bool {
        lhs.dateStart < rhs.dateStart
    }
    
    let id, date, coursetype, cancelled: String
        let coursename, level, days, isspecial: String
//        let students: [Student]?
        let bgcolor, numstudents: String
    
    
    var dateStart: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: date) ?? Date()
        
    }
    var dateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: dateStart) 
        
    }
    var courseFullName: String {
        return coursename + " " + level
    }
    var isActual: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.date(from: date) ?? Date()
        
        if (Date() < date + ( Double(days) ?? 0 ) * 86400), (Date() > date) {
            return true
        } else {
            return false
        }
    }
}


// MARK: - Student
struct Student: Codable, Identifiable {
   
    
    let id, studentid, name, phone, isapproved, ispaid: String
    let isconfirmed, iscalled,  cancelled, comment: String
    
    var isConfirmed:Bool {
        isconfirmed == "1" ?  true :  false
    }
    var selectedConfirmation: Bool?
    
}

struct Login: Codable {
    let lethimin: String
    var response: Bool {
        lethimin == "true" ? true : false
    }
}

    

