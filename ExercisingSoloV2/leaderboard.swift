//
//  leaderboard.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI

struct leaderboard: View {
    @State var backgroundColor: Color = .blue
    var body: some View {
        ZStack{
            backgroundColor.opacity(0.4)
                .ignoresSafeArea()
            //Leaderboard frame and title
            RoundedRectangle(cornerRadius: 45)
                .fill(Color.cyan)
                .frame(width: 350, height: 450)
                .offset(x: 0, y: 80)
            RoundedRectangle(cornerRadius: 35)
                .fill(Color.white)
                .frame(width: 325, height: 425)
                .offset(x: 0, y: 80)
            Text("Leaderboard")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(.black)
                .padding()
                .offset(x: 0, y: -100)
            //1st, 2nd, and 3rd, bars
            HStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 50, height: 125)
                    .offset(x: 0, y: -235)
                    .padding()
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 50, height: 150)
                    .offset(x: 0, y: -245)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 50, height: 75)
                    .offset(x: 0, y: -210)
                    .padding()
            }
            //Placing labels
            Text("1st")
                .offset(x: 0, y: -300)
                .font(.system(size: 20, weight: .bold, design: .default))
            Text("2nd")
                .offset(x: -75, y: -275)
                .font(.system(size: 20, weight: .bold, design: .default))
            Text("3rd")
                .offset(x: 75, y: -230)
                .font(.system(size: 20, weight: .bold, design: .default))
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 100)
                .offset(x: 0, y: 400)
        }
    }
}

#Preview {
    leaderboard()
}
