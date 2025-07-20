//
//  tabs.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/19/25.
//

import SwiftUI

struct tabs: View {
    var body: some View {
        TabView{
            home()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            quests()
                .tabItem{
                    Image(systemName: "scroll")
                    Text("Quests")
                }

            leaderboard()
                .tabItem{
                    Image(systemName: "trophy")
                    Text("Leaderboard")
                }
            shop()
                .tabItem{
                    Image(systemName: "star")
                    Text("Shop")
                }
        }
    }
}


#Preview {
    tabs()
}
