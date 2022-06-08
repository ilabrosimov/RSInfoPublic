//
//  CourseViewCell.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/8/21.
//

import SwiftUI

struct CourseViewCell: View {
    
    @State var course: Course
    var body: some View {
        
        VStack (alignment: .leading) {
            Text(course.courseFullName)
                HStack {
                    Text(course.dateFormatted).fontWeight(.thin)
                    Spacer()
                    Image(systemName: "person.fill").offset(x: 5.0)
                    Text(course.numstudents).padding(.trailing, 5)
                    Image(systemName: "calendar").offset(x: 5.0)
                    Text(course.days).padding(.trailing)
                }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 25)
        .foregroundColor(.black)
        .background(Color(UIColor("#\(course.bgcolor)") ?? UIColor.white))
        .clipShape(Capsule())
        .background(Color.clear)

    }
}
//struct CourseViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseViewCell(course: Course(id: "172", date: "25-10-2021", coursetype: "26", cancelled: "0", coursename: "SB", level: "Умеющие", days: "4", isspecial: "0", bgcolor: "dce9d5ff", numstudents: "6"))
//
//    }
//}

