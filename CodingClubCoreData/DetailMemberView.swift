//
//  DetailMemberView.swift
//  CodingClubCoreData
//
//  Created by Ayu Lestari Ramadani on 04/07/23.
//

import SwiftUI

struct DetailMemberView: View {
    @State private var showEditSheet = false
    
    // 2.1 Add observedobject for crawl data from coredata and array role for show role data
    @ObservedObject var member: Member
    private let role = ["Designer", "Coder", "Domain"]

    var body: some View {
        List{
            Section{
                VStack(alignment: .leading, spacing: 4){
                    // 2.2 add object that we want to call
                    Text("Name : \(member.name!)")
                      .font(.headline)
                    Text("Age : \(age(from: member.birth!))")
                      .font(.headline)
                    Text("Gender : \(getString(from: member.gender))")
                        .font(.headline)
                    Text("Role : \(role[Int(member.role)])")
                      .font(.headline)
                    Text("Avatar :")
                      .font(.headline)
                    if let imageData = member.image, let image = UIImage(data: imageData) {
                      Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    }
                      
                }
            }
        }
        .sheet(isPresented: $showEditSheet, content: {
          EditMemberView(member: member)
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
    // Function for change bool to string
    func getString(from value: Bool) -> String {
            return value ? "Male" : "Female"
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

// 2.3 Remove preview (Soalnya ribet :))
//struct DetailMemberView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailMemberView()
//    }
//}
