//
//  LectorModel.swift
//  RSInfo
//
//  Created by ilabrosimov on 02.08.2021.
//

import Foundation

struct Course: Codable,Hashable {
  
    let name: String
    let sport: Sport
    var lector: Lector
    var students: [Student]
    
    var startDate: Date
    var endDate: Date
}

struct Lector:  Codable, Hashable {
    let name: String
    let lastName: String
    var fullName: String {
        return "\(lastName) \(name)"
    }
}

struct Student: Hashable, Codable  {
    var name:String
    var phone:String
    var confirmation: Bool = false
}

enum Sport: String, Codable, CaseIterable {
    case ski = "⛷"
    case snowboard = "🏂"
}




//enum CourseType: String, Codable, CaseIterable {
//    case green = "Новички", blue = "Умеющие", red = "Про"
//}
//    case mogulGreen = "Могул новички", mogulBlue = "Могул катающиеся"
//    case carvingGreen = "Карвинг начинающие", carvingPro = "Карвинг катающиеся"
//    case flatFreeStyle = "Базовый фристайл", park = "Прыжки в парке"
//    case freeride = "Фрирайд"

//enum SkiCourseType: String, Codable, CaseIterable {
//    case green = "Новички", blue = "Умеющие", red = "Про"
//    case upsGreen = "UPS новички", upsBlue = "UPS Катающиеся"
//    case mogulGreen = "Могул новички", mogulBlue = "Могул катающиеся"
//    case carvingGreen = "Карвинг начинающие", carvingPro = "Карвинг катающиеся"
//    case freeStyle = "Фристайл первые шаги", freeStylePro = "Прыжки в парке", freeStyleBackflip = "Бэкфлип"
//    case simpleSki = "Лыжи - просто!"
//    case freeride = "Техника внетрассового катания"
//    case telemark = "Телемарк"
//    case shortTurns = "Малый радиус"
//}
//enum SnowboardCourseType: String, Codable, CaseIterable {
//    case green = "Новички", blue = "Умеющие", red = "Про"
//    case carvingGreen = "Карвинг начинающие", carvingPro = "Карвинг катающиеся"
//    case freeStyle = "Флэт фристайл",freeStyleShred = "Шред", freeStylePro = "Прыжки в парке", freeStyleBackflip = "Бэкфлип"
//    case freeride = "Техника внетрассового катания"
//}
