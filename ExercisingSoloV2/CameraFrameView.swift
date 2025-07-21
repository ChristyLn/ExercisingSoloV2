//
//  CameraFrameView.swift
//  ExercisingSoloV2
//
//  Created by 44GOParticipant on 7/16/25.
//

import Foundation
//
//  CameraFrameView.swift
//  ExercisingSoloV2
//
//  Created by 44GOParticipant on 7/16/25.
//

import SwiftUI
//NEW VERSION

struct CameraFrameView: View {
    var image: CGImage?
    private let label = Text(" ")

    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .right, label: label)
                .resizable()
                .scaledToFill()
        } else {
            Color.black
        }
    }
}

// This preview should also pass nil or a test image
#Preview {
    CameraFrameView(image: nil)
}
