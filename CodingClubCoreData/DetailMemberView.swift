//
//  DetailMemberView.swift
//  CodingClubCoreData
//
//  Created by Ayu Lestari Ramadani on 04/07/23.
//

import SwiftUI

struct DetailMemberView: View {
    @State private var selectedOptionIndex = 0
    private let options = [false, true]
    @State private var showEditSheet = false
    
    let birthDate = Date()

    var body: some View {
        List{
            Section{
                VStack(alignment: .leading, spacing: 4){
                    Text("Name : ")
                      .font(.headline)
                    Text("Age : \(age(from: birthDate))")
                      .font(.headline)
                    Text("Gender : ")
                        .font(.headline)
                    Text("Role :")
                      .font(.headline)
                    Text("Avatar :")
                      .font(.headline)
                      
                }
            }
        }
        .sheet(isPresented: $showEditSheet, content: {
          EditMemberView()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditSheet.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
    }
    
    func age(from date: Date) -> String {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        
        if let age = ageComponents.year {
            return "\(age) years"
        } else {
            return "N/A"
        }
    }
}

struct DetailMemberView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMemberView()
    }
}
