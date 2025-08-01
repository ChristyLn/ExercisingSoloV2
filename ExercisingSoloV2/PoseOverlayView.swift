//
//  PoseOverlayView.swift
//  Camera2.0
//
//  Created by 44GOParticipant on 7/14/25.
//

import SwiftUI
import Vision
//NEW VERSION
struct PoseOverlayView: View {
        // 1.
        let bodyParts: [HumanBodyPoseObservation.JointName: CGPoint]
        let connections: [BodyConnection]
        
        var body: some View {
            GeometryReader { geometry in
                
                // 2.
                ZStack {
                    ForEach(connections) { connection in
                        if let fromPoint = bodyParts[connection.from],
                           let toPoint = bodyParts[connection.to] {
                            Path { path in
                                let fromPointInView = CGPoint(
                                    x: fromPoint.x * geometry.size.width,
                                    y: fromPoint.y * geometry.size.height
                                )
                                let toPointInView = CGPoint(
                                    x: toPoint.x * geometry.size.width,
                                    y: toPoint.y * geometry.size.height
                                )
                                
                                path.move(to: fromPointInView)
                                path.addLine(to: toPointInView)
                            }
                            .stroke(Color.green, lineWidth: 3)
                        }
                    }
                    // 3.
                    ForEach(Array(bodyParts.keys), id: \.self) { jointName in
                        if let point = bodyParts[jointName] {
                            let pointInView = CGPoint(
                                x: point.x * geometry.size.width,
                                y: point.y * geometry.size.height
                            )
                            
                            Circle()
                                .fill(.white)
                                .frame(width: 10, height: 10)
                                .position(pointInView)
                                .overlay(
                                    ZStack{
                                        Circle()
                                            .stroke(Color.white, lineWidth: 1)
                                            .frame(width: 12, height: 12)
                                        
                                        
                                    }
                                )
                        }
                    }
                }
            }
        }
    }
    #Preview {
        let sampleBodyParts: [HumanBodyPoseObservation.JointName: CGPoint] = [
                .leftShoulder: CGPoint(x: 0.3, y: 0.4),
                .rightShoulder: CGPoint(x: 0.7, y: 0.4)
            ]

            let sampleConnections: [BodyConnection] = [
                BodyConnection(from: .leftShoulder, to: .rightShoulder)
            ]

            return PoseOverlayView(bodyParts: sampleBodyParts, connections: sampleConnections)
    }

