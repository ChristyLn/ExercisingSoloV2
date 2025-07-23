import SwiftUI
import Vision
import AVFoundation
import Observation

// 1.
struct BodyConnection: Identifiable {
    let id = UUID()
    let from: HumanBodyPoseObservation.JointName
    let to: HumanBodyPoseObservation.JointName
        
}

class PoseEstimationViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @Published var detectedBodyParts: [HumanBodyPoseObservation.JointName: CGPoint] = [:]
    @Published var bodyConnections: [BodyConnection] = []
    @Published var jjumpingJackCount: Int = 0
    @Published var pushUpCount: Int = 0
    @Published var latestObservation: HumanBodyPoseObservation?
    var jumpingJackPrevPhase: JumpingJackPhase = .closed
    var jumpingJackCurrentPhase: JumpingJackPhase = .closed
    var pushPrevPhase: HeadPosition = .up
    var pushCurrentPha: HeadPosition = .up

    
    override init() {
        super.init()
        setupBodyConnections()
    }
    
    // 3.
    private func setupBodyConnections() {
        bodyConnections = [
            BodyConnection(from: .nose, to: .neck),
            BodyConnection(from: .neck, to: .rightShoulder),
            BodyConnection(from: .neck, to: .leftShoulder),
            BodyConnection(from: .rightShoulder, to: .rightHip),
            BodyConnection(from: .leftShoulder, to: .leftHip),
            BodyConnection(from: .rightHip, to: .leftHip),
            BodyConnection(from: .rightShoulder, to: .rightElbow),
            BodyConnection(from: .rightElbow, to: .rightWrist),
            BodyConnection(from: .leftShoulder, to: .leftElbow),
            BodyConnection(from: .leftElbow, to: .leftWrist),
            BodyConnection(from: .rightHip, to: .rightKnee),
            BodyConnection(from: .rightKnee, to: .rightAnkle),
            BodyConnection(from: .leftHip, to: .leftKnee),
            BodyConnection(from: .leftKnee, to: .leftAnkle)
        ]
    }

    // 4.
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        Task {
            if let detectedPoints = await processFrame(sampleBuffer) {
                DispatchQueue.main.async {
                    self.detectedBodyParts = detectedPoints
                }
            }
        }
    }

    func processFrame(_ sampleBuffer: CMSampleBuffer) async -> [HumanBodyPoseObservation.JointName: CGPoint]? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }

        let request = DetectHumanBodyPoseRequest()

        do {
            let results = try await request.perform(on: imageBuffer, orientation: .right)
            guard let firstObservation = results.first else { return nil }
            
            let exerciSe = Exercise()
            let (newCount, newPhase, jJackCurrentPhase) = exerciSe.jumpingJack(observation: firstObservation, currentCount: jjumpingJackCount, previousPhase: jumpingJackPrevPhase, currentPhase: jumpingJackCurrentPhase)
            //let (newCountPush, newPhasePush, pushCurrentPhase) = exerciSe.pushUp(observation: firstObservation, currentCount: pushUpCount, previousPhase: pushPrevPhase, currentPhase: pushCurrentPha)
            
            DispatchQueue.main.async {
                self.jjumpingJackCount = newCount
                self.jumpingJackPrevPhase = newPhase
                self.latestObservation = firstObservation
                self.jumpingJackCurrentPhase = jJackCurrentPhase
//                self.pushUpCount = newCountPush
//                self.pushPrevPhase = newPhasePush
//                self.pushCurrentPha = pushCurrentPhase
            }

            return extractPoints(from: firstObservation)
        } catch {
            print("Error processing frame: \(error.localizedDescription)")
            return nil
        }
    }


    // 6.
    func extractPoints(from observation: HumanBodyPoseObservation) -> [HumanBodyPoseObservation.JointName: CGPoint] {
        var detectedPoints: [HumanBodyPoseObservation.JointName: CGPoint] = [:]
        let humanJoints: [HumanBodyPoseObservation.PoseJointsGroupName] = [.face, .torso, .leftArm, .rightArm, .leftLeg, .rightLeg]
        
        for groupName in humanJoints {
            let jointsInGroup = observation.allJoints(in: groupName)
            for (jointName, joint) in jointsInGroup {
                if joint.confidence > 0.5 { // Ensuring only high-confidence joints are added
                    //let point = joint.location.verticallyFlipped().cgPoint
                    let point = CGPoint(x: joint.location.x, y: 1-joint.location.y)
                    detectedPoints[jointName] = point
                }
            }
        }
        return detectedPoints
    }
}
