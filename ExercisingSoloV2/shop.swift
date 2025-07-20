//
//  shop.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/11/25.
//

import SwiftUI

struct shop: View {
    @State private var selectedItem: ShopItem?
    @State private var coins = 100
    @State private var ownedItems: Set<UUID> = []

    let items = [
        ShopItem(name: "Red Hat", imageName: "hat", price: 30),
        ShopItem(name: "Blue Shirt", imageName: "tshirt", price: 40),
        ShopItem(name: "Green Pants", imageName: "pants", price: 25),
        ShopItem(name: "Cool Shoes", imageName: "shoeprints.fill", price: 20),
        ShopItem(name: "Magic Cloak", imageName: "shield.fill", price: 50),
        ShopItem(name: "Sunglasses", imageName: "eyeglasses", price: 15)
    ]

    var body: some View {
        ZStack {
            Color.blue.opacity(0.4).ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Shop")
                    .font(.system(size: 50, weight: .bold, design: .default))
                // Coin counter
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 150, height: 50)
                        .offset(x: -125)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.yellow)
                        Text("Coins: \(coins)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                }

                // Character display
                ZStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)

                    if let item = selectedItem {
                        Image(systemName: item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(y: -50)
                            .foregroundColor(.yellow)
                    }
                }

                Text("Character Preview")
                    .font(.headline)
                    .foregroundColor(.white)

                Divider()
                    .background(.white)

                Text("Shop")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(items) { item in
                            VStack(spacing: 8) {
                                Image(systemName: item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                Text(item.name)
                                    .font(.caption)

                                Text("\(item.price) 🪙")
                                    .font(.caption2)
                                    .foregroundColor(.gray)

                                // Buy/Equip/Equipped Logic
                                if !ownedItems.contains(item.id) {
                                    Button("Buy") {
                                        if coins >= item.price {
                                            coins -= item.price
                                            ownedItems.insert(item.id)
                                        }
                                    }
                                    .font(.caption)
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                } else if selectedItem?.id == item.id {
                                    Text("Equipped")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                } else {
                                    Button("Equip") {
                                        selectedItem = item
                                    }
                                    .font(.caption)
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                }
                            }
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .frame(width: 120)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Character Shop")
    }
}

struct ShopItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Int
}

#Preview {
    NavigationView {
        shop()
    }
}


