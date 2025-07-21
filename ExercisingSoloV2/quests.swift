//
//  quests.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI
import Vision
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
                        NavigationLink(destination: cameraViewPushUps()){
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
                            Text("10 sit-ups")
                        }
                        .offset(x: -50)
                        NavigationLink(destination: cameraViewSitups()){
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
                    //Daily Quest: 10 jumping jacks
                    ZStack{
                        RoundedRectangle(cornerRadius: 45)
                            .fill(.white)
                            .frame(width: 350, height:150)
                        VStack{
                            Text("Daily Quest")
                            Text("10 jumping jacks")
                        }
                        .offset(x: -50)
                        NavigationLink(destination: cameraViewJumpingJacks()){
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
                        NavigationLink(destination: cameraViewWalking()){
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

struct cameraViewJumpingJacks: View {
    @StateObject private var model = FrameHandler()
    @State private var jumpingJackCount = 0
    @State private var prevPhase = JumpingJackPhase.closed
    @State private var currentPhase = JumpingJackPhase.closed
    private var poseViewModel = PoseEstimationViewModel()
    private var exercise = Exercise()
    let goal = 10

    var body: some View {
        ZStack {
            CameraFrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)

            PoseOverlayView(
                bodyParts: poseViewModel.detectedBodyParts,
                connections: poseViewModel.bodyConnections
            ).edgesIgnoringSafeArea(.all)
            Rectangle()
                .fill(Color.red)
                .frame(width:200, height:100)
                .offset(x: -280, y: -430)
            Text("\(jumpingJackCount)")
                .font(.system(size: 84))
                .foregroundColor(.white)
                .offset(x: -280, y: -430)
        }
        .task {
            await model.checkPermission()
            model.delegate = poseViewModel
        }
        .onReceive(poseViewModel.$latestObservation.compactMap { $0 }) { observation in
            let (newCount, oldPhase,jJackCurrentPhase) = exercise.jumpingJack(observation: observation, currentCount: jumpingJackCount, previousPhase: prevPhase, currentPhase: currentPhase)
            prevPhase = oldPhase
            currentPhase = jJackCurrentPhase
            if newCount != jumpingJackCount {
                jumpingJackCount = newCount
            }
        }
    }
}


struct cameraViewPushUps: View {
    @StateObject private var model = FrameHandler()
    @State private var pushUpCount = 0
    @State private var prevPhase = JumpingJackPhase.closed
    @State private var currentPhase = JumpingJackPhase.closed
    private var poseViewModel = PoseEstimationViewModel()
    private var exercise = Exercise()
    let goal = 10
    var body: some View {
        ZStack{
            CameraFrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            PoseOverlayView(
                bodyParts: poseViewModel.detectedBodyParts,
                connections: poseViewModel.bodyConnections
            ).edgesIgnoringSafeArea(.all)
            Rectangle()
                .fill(Color.red)
                .frame(width:200, height:100)
                .offset(x: -280, y: -430)
            Text("\(poseViewModel.pushUpCount)")
                .font(.system(size: 84))
                .foregroundColor(.white)
                .offset(x: -280, y: -430)
            
            
        }.task {
            await model.checkPermission()
            model.delegate = poseViewModel
        }
    }
}


struct cameraViewSitups: View {
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
            Rectangle()
                .fill(Color.red)
                .offset(x:-400, y:300)
                .frame(width: 200, height: 100)
        }.task {
            await model.checkPermission()
            model.delegate = poseViewModel
        }
    }
}


struct cameraViewWalking: View {
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
            Rectangle()
                .fill(Color.red)
                .offset(x:-400, y:300)
                .frame(width: 200, height: 100)
        }.task {
            await model.checkPermission()
            model.delegate = poseViewModel
        }
    }
}
#Preview {
    quests()
}
