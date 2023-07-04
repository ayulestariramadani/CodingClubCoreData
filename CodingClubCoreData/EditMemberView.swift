//
//  EditMemberView.swift
//  CodingClubCoreData
//
//  Created by Ayu Lestari Ramadani on 04/07/23.
//

import SwiftUI

struct EditMemberView: View {
    @Environment(\.presentationMode) var presentationMode
    //3.1. add environment variable from persistance and object
    @Environment(\.managedObjectContext) var viewContext
    let member: Member
    
    @State private var name: String = ""
    @State private var selectedDate = Date()
    
    @State private var selectedGender = 0
    private let gender = [false, true]
    
    @State private var selectedRole = 0
    private let role = ["Designer", "Coder", "Domain"]
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    //3.4 initialize for null string
    private var hasInvalidData: Bool {
        return member.name!.isBlank || (member.name == name && member.birth == selectedDate && member.gender == (selectedGender != 0) && member.role == selectedRole)
    }

    
    var body: some View {
        NavigationView {
            Form {
                // Section Profile
                Section {
                    TextField("Name", text: $name)
                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    Picker("Select ", selection: $selectedGender) {
                        ForEach(0..<gender.count) { index in
                            Text(gender[index] ? "Male" : "Female")
                                .tag(index)
                        }
                    }
                } header: {
                  Text("Profile")
                } footer: {
                  Text("Name is required")
                    .font(.caption)
                    .foregroundColor(name.isBlank ? .red : .clear)
                }
                
                // Section Role
                Section{
                    Picker("Select ", selection: $selectedRole) {
                        ForEach(0..<role.count) { index in
                            Text(role[index])
                                .tag(index)
                        }
                    }
                }header: {
                    Text("Role")
                }
                
                // Section Image
                Section {
                  if image == nil {
                    Button {
                      self.showingImagePicker = true
                    } label: {
                      Text("Add a photo")
                    }
                  }

                  image?
                    .resizable()
                    .scaledToFit()
                }
                
                // Section Button
                // 3.3 remove section button
//                Section {
//                    Button {
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Text("Save")
//                    }
//                    .disabled(name.isBlank)
//                }
                
                
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
              ImagePicker(image: $inputImage)
            }
            .navigationTitle("Edit Member Details")
            .navigationBarTitleDisplayMode(.inline)
            // 3.5 add toolbar
            .toolbar {
              ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                  viewContext.performAndWait {
                      member.name = name
                      member.birth = selectedDate
                      member.role = Int16(selectedRole)
                      member.gender = (selectedGender != 0)
                      if inputImage != nil{
                          let imageData = inputImage?.jpegData(compressionQuality: 0.8)
                          member.image = imageData
                      }
                      
                      do {
                          try viewContext.save()
                      } catch {
                          // Replace this implementation with code to handle the error appropriately.
                          // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                          let nsError = error as NSError
                          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                      }
                    presentationMode.wrappedValue.dismiss()
                  }
                } label: {
                  Text("Save")
                }
                .disabled(hasInvalidData)
              }
              ToolbarItem(placement: .navigationBarLeading) {
                Button {
                  presentationMode.wrappedValue.dismiss()
                } label: {
                  Text("Cancel")
                }
              }
            }
        }
        //3.2 assign data from core data to the variable
        .onAppear(){
            name = member.name!
            selectedDate = member.birth!
            selectedRole = Int(member.role)
            selectedGender = member.gender ? 1 : 0

            
        }
    }
}

// MARK: Loading image and creating a new member
extension EditMemberView{
    private func loadImage() {
      guard let inputImage = inputImage else { return }
      image = Image(uiImage: inputImage)
    }
}

// 3.2 Remove preview dari pada ribet
//struct EditMemberView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMemberView()
//    }
//}
