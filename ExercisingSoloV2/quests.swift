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
                   HStack{
                    VStack{
                        Text("Daily Quest")
                        Text("10 push-ups")
                    }
                       NavigationLink(destination: ()){
                           
                       }
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
#Preview {
    quests()
}
