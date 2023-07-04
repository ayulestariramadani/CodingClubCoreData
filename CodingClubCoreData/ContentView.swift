//
//  ContentView.swift
//  CodingClubCoreData
//
//  Created by Ayu Lestari Ramadani on 04/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.name, ascending: true)],
        animation: .default)
    private var members: FetchedResults<Member>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(members) { member in
                    NavigationLink {
                        // 2.4 Add parameter
                        DetailMemberView(member: member)
                    } label: {
                        //1.4. Edit label for list
                        Text("\(member.name!)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddMemberView()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Member List")
            
        }
    }
}

// 4.1 add delete function
extension ContentView{
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { members[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
