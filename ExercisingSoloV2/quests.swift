//
//  quests.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI
struct quests: View {
    @State var backgroundColor: Color = .blue
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor.opacity(0.4)
                    .ignoresSafeArea()
                VStack{
                    //Quest Title
                    Text("Quests")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .offset(x:0 , y: 25)
                    //Daily Quest: 10 push-ups
                    ZStack{                    RoundedRectangle(cornerRadius: 45)
                            .fill(.white)
                            .frame(width: 350, height:150)
                        VStack{
                            Text("Daily Quest")
                            Text("10 push-ups")
                        }
                        .offset(x: -50)
                        NavigationLink(destination: cameraView()){
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.blue)
                                    .frame(width: 75, height: 75)
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(x: 75)
                    }
                    //Daily Quest: 10 curl-ups
                    ZStack{
                        RoundedRectangle(cornerRadius: 45)
                            .fill(.white)
                            .frame(width: 350, height:150)
                        VStack{
                            Text("Daily Quest")
                            Text("10 curl-ups")
                        }
                        .offset(x: -50)
                        NavigationLink(destination: cameraView()){
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.blue)
                                    .frame(width: 75, height: 75)
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(x: 75)
                    }
                    //Daily Quest: 10 squats
                    ZStack{
                        RoundedRectangle(cornerRadius: 45)
                            .fill(.white)
                            .frame(width: 350, height:150)
                        VStack{
                            Text("Daily Quest")
                            Text("10 squats")
                        }
                        .offset(x: -50)
                        NavigationLink(destination: cameraView()){
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.blue)
                                    .frame(width: 75, height: 75)
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(x: 75)
                    }
                    //Daily Quest: 10,000 steps
                    ZStack{
                        RoundedRectangle(cornerRadius: 45)
                            .fill(.white)
                            .frame(width: 350, height:150)
                        VStack{
                            Text("Daily Quest")
                            Text("10,000 steps")
                        }
                        .offset(x: -50)
                        NavigationLink(destination: cameraView()){
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.blue)
                                    .frame(width: 75, height: 75)
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                            }
                        }
                        .offset(x: 75)
                    }
                }
                //White tab bar
                .offset(x: 0 , y: -30)
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 400, height: 100)
                    .offset(x:0 , y: 400)
            }
        }
    }
}

struct cameraView: View {
    @StateObject private var model = FrameHandler()
    private var poseViewModel = PoseEstimationViewModel()
    var body: some View {
        ZStack{
            CameraFrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            PoseOverlayView(
                bodyParts: poseViewModel.detectedBodyParts,
                connections: poseViewModel.bodyConnections
            ).edgesIgnoringSafeArea(.all)
        }.task {
            await model.checkPermission()
            model.delegate = poseViewModel
        }
    }
}

#Preview {
    quests()
}
