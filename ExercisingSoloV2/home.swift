//
//  home.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI
struct home: View {
    var image: CGImage?
    private let label = Text("frame")
    // line 10 and 11 camera variables
    
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
                  
                    //camera stuff
                    if let image = image {
                        Image(image, scale: 1.0, orientation: .up, label: label)
                            .resizable()
                            
                    } else {
                        Color.black
                    }

                }
                
                
            }
        }
    }
}

struct profile: View {
    @State var backgroundColor: Color = .blue
    var body: some View {
        ZStack{
            backgroundColor.opacity(0.4)
                .ignoresSafeArea()
            Text("Profile")
                .font(.system(size: 50, weight: .bold))
                .offset(x: 0 , y: -350)
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
            .offset(x: 140, y: -350)
        }
    }
}

struct settings: View {
    @State var backgroundColor: Color = .blue
    var body: some View {
        ZStack{
            backgroundColor.opacity(0.4)
                .ignoresSafeArea()
            Text("Settings")
                .font(.system(size: 50, weight: .bold))
                .offset(x: 0, y: -325)
        }
    }
}

#Preview {
    home()
}

