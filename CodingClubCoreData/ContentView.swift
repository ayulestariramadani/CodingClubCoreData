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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        // 2.4 Add parameter
                        DetailMemberView()
                    } label: {
                        //2.5. Edit label for list
                        Text("Go To Detail Member View")
                    }
                }
                //4.2 call delete function
//                .onDelete()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
