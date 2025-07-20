//
//  home.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI
import PhotosUI

struct home: View {
    @StateObject private var model = FrameHandler()
    private var poseViewModel = PoseEstimationViewModel()
    @State var backgroundColor: Color = .blue
    
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    // Background color layer
                    backgroundColor.opacity(0.4)
                        .ignoresSafeArea()
                    
                    // White tab bar
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .frame(width: 250, height: 140)
                        .offset(x: -55, y: -280)
                    
                    //Exp bar
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.green)
                        .frame(width: 225, height: 10)
                        .offset(x: -55, y: -245)
                    Text ("0/100")
                        .font(.system(size: 20, weight: .light))
                        .offset(x: 10, y: -225)
                    
                    // ✅ NavigationLink wrapped around the blue circle
                    NavigationLink(destination: profile()) {
                        Circle()
                            .fill(backgroundColor)
                            .frame(width: 75, height: 75)
                            .overlay(
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(15)
                                    .foregroundColor(.white)
                            )
                    }
                    .offset(x: -125, y: -300)
                    
                    // User text
                    Text("User")
                        .font(.system(size: 30, weight: .bold))
                        .offset(x: -30, y: -315)
                    Text("Level 1")
                        .font(.system(size: 30, weight: .bold))
                        .offset(x: -30, y: -275)
                    
                    // Coins area
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 100, height: 50)
                        .offset(x: 130, y: -315)
                    Text("0")
                        .font(.system(size: 30, weight: .bold))
                        .offset(x: 145, y: -315)
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: 100, y: -315)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 400, height: 100)
                        .offset(x: 0, y: 425)
                }
            }
        }
    }
}


struct profile: View {
    @State private var username = "User"
    @State private var email = "User@example.com"
    @State private var bio = "Lover of design and code ✨"
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var profileImage: Image?
    @State var backgroundColor: Color = .blue

    var body: some View {
        NavigationStack{
            NavigationView {
                    VStack(spacing: 20) {
                        Text("Profile")
                            .font(.system(size: 30, weight: .bold))
                        NavigationLink(destination: settings()) {
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 75, height: 75)
                                            .overlay(Image(systemName: "gear")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(15)
                                                .foregroundColor(.white)
                                            )
                                    }
                        .offset(x: 100)
                        // Profile Image (default or selected)
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                        }
                        
                        // Photo Picker
                        PhotosPicker("Select Photo", selection: $selectedPhoto, matching: .images)
                            .onChange(of: selectedPhoto) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        profileImage = Image(uiImage: uiImage)
                                    }
                                }
                            }
                        
                        // Username field
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        // Email
                        Text(email)
                            .foregroundColor(.secondary)
                        
                        // Bio
                        TextEditor(text: $bio)
                            .frame(height: 100)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
                            .padding(.horizontal)
                        
                        // Save Button
                        Button("Save Changes") {
                            // Save logic here
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                }
            }
        }
    }
}


struct settings: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("theme") private var selectedTheme = "Light"
    
    let themes = ["Light", "Dark", "System"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    
                    Picker("App Theme", selection: $selectedTheme) {
                        ForEach(themes, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    home()
}


