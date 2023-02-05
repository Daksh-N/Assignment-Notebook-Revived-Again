//
//  AddItemView.swift
//  Assignment Notebook Revived
//
//  Created by Daksh Nakra on 1/27/23.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var assignmentlist: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Computer Science", "English", "Math"]
    var body: some View {
        NavigationView {
            Form {
                Picker("Select Course:", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .font(Font.custom("Marker Felt", size: 20))
            .navigationBarTitle(Text("Add New Assignment"), displayMode: .inline)
            .navigationBarItems(trailing: Button("Save"){
                if course.count > 0 && description.count > 0 {
                    let item = Assignment(id: UUID(), course: course, description: description, dueDate: dueDate)
                    assignmentlist.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .preferredColorScheme(.dark)
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(assignmentlist: AssignmentList())
    }
}

