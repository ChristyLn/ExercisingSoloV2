//
//  shop.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI

struct shop: View {
    @State var backgroundColor: Color = .blue
    var body: some View {
        ZStack{
            backgroundColor.opacity(0.4)
                .ignoresSafeArea()
            
            //Shelf Designs
            Rectangle()
                .fill(Color.brown)
                .frame(width: 450, height: 350)
                .offset(x: 0, y: 175)
            Rectangle()
                .fill(Color.white).opacity(0.2)
                .frame(width: 450, height: 50)
                .offset(x: 0, y: 25)
            Rectangle()
                .fill(Color.white).opacity(0.2)
                .frame(width: 450, height: 50)
                .offset(x: 0, y: 175)
            Rectangle()
                .fill(Color.white).opacity(0.2)
                .frame(width: 450, height: 50)
                .offset(x: 0, y: 325)
            
            //Price labels
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 75, height: 30)
                .offset(x: 0, y: 175)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 75, height: 30)
                .offset(x: 125, y: 175)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 75, height: 30)
                .offset(x: -125, y: 175)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 75, height: 30)
                .offset(x: 0, y: 325)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 75, height: 30)
                .offset(x: 125, y: 325)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 75, height: 30)
                .offset(x: -125, y: 325)
            
            //Shop sign
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 100, height: 30)
                .offset(x: 0, y: 25)
            Text("Shop")
                .font(.system(size: 25, weight: .bold, design: .default))
                .offset(x: 0, y: 25)
            
            //Price label numbers
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: 0, y: 175)
                Text("10")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .offset(x: 0, y: 175)
            }
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: 125, y: 175)
                Text("15")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .offset(x: 125, y: 175)
            }
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: -125, y: 175)
                Text("5")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .offset(x: -125, y: 175)
            }
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: 0, y: 325)
                Text("25")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .offset(x: 0, y: 325)
            }
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: 125, y: 325)
                Text("30")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .offset(x: 125, y: 325)
            }
            HStack {
                Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: -125, y: 325)
                Text("20")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .offset(x: -125, y: 325)
            }
            
            //White tab bar
            Rectangle()
                .fill(Color.white)
                .frame(width: 400, height: 100)
                .offset(x: 0, y: 400)
        }
    }
}

#Preview {
    shop()
}
