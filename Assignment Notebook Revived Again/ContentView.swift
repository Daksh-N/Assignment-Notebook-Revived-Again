//
//  ContentView.swift
//  Assignment Notebook Revived
//
//  Created by Daksh Nakra on 1/27/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddItemView = false
    var body: some View {
            NavigationView {
                List {
                    ForEach(assignmentList.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.course)
                                    .font(.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text(item.dueDate, style: .date)
                        }
                    }
                    .onMove { indices, newOffset in
                        assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    .onDelete { indexSet in
                        assignmentList.items.remove(atOffsets: indexSet)
                    }
                }
                .sheet(isPresented: $showingAddItemView, content: {
                    AddItemView(assignmentlist: assignmentList)
                })
                .navigationBarTitle("Assignments", displayMode: .inline)
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {showingAddItemView = true}) {
                    Image(systemName: "plus")
                })
                .font(Font.custom("Marker Felt", size: 20))
                .background(.yellow)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct Assignment: Identifiable, Codable {
        var id = UUID()
        var course: String
        var description: String
        var dueDate = Date()
    }
    
    struct CustomText: View {
        let text: String
        var body: some View {
            Text(text).font(Font.custom("Marker Felt", size: 36))
        }
    }
    
