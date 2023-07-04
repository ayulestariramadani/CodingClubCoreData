//
//  AddMemberView.swift
//  CodingClubCoreData
//
//  Created by Ayu Lestari Ramadani on 04/07/23.
//

import SwiftUI

struct AddMemberView: View {
    @Environment(\.presentationMode) var presentationMode
    //1.1. add environment variable persistance
    
    @State private var name: String = ""
    @State private var selectedDate = Date()
    
    @State private var selectedGender = 0
    private let gender = [false, true]
    
    @State private var selectedRole = 0
    private let role = ["Designer", "Coder", "Domain"]
    
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
    
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
                Section {
                    Button {
                        // 1.3. Call addItem Function
                        
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(name.isBlank)
                }
                
                
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
              ImagePicker(image: $inputImage)
            }
            .navigationTitle("Add Member")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: Loading image and creating a new member
extension AddMemberView{
    private func loadImage() {
      guard let inputImage = inputImage else { return }
      image = Image(uiImage: inputImage)
    }
    //1.2. Add function for add new data
    
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}

// MARK: String
extension String {
  var isBlank: Bool {
    self.trimmingCharacters(in: .whitespaces).isEmpty
  }
}

