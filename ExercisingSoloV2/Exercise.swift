//
//  Exercise.swift
//  ExercisingSoloV2
//
//  Created by 44GOParticipant on 7/16/25.
//

//NEW VERSION
import Foundation
import Vision
import Observation

enum JumpingJackPhase {
    case open, closed
}

enum HeadPosition{
    case up, down
}


class Exercise{
    let poseMaths = PoseEstimationViewModel()
    private var lastCountTime:TimeInterval = 0
    
    func jumpingJack(observation: HumanBodyPoseObservation, currentCount: Int, previousPhase: JumpingJackPhase, currentPhase: JumpingJackPhase) -> (Int, JumpingJackPhase,JumpingJackPhase) {
        let joints = poseMaths.extractPoints(from: observation)
        
        guard let leftWrist = joints[.leftWrist],
              let rightWrist = joints[.rightWrist],
              let leftShoulder = joints[.leftShoulder],
              let rightShoulder = joints[.rightShoulder],
              let leftAnkle = joints[.leftAnkle],
              let rightAnkle = joints[.rightAnkle] else {
            return (currentCount, previousPhase, currentPhase)
        }

        let armThreshold: CGFloat = 0.05
        let legThreshold: CGFloat = 0.01

        let armsUp = (leftWrist.y - leftShoulder.y) > armThreshold ||
                     (rightWrist.y - rightShoulder.y) > armThreshold

        let legsApart = (leftAnkle.x < leftShoulder.x - legThreshold) ||
                        (rightAnkle.x > rightShoulder.x + legThreshold)

        var newCount = currentCount
        var prePhase = previousPhase
        var cPhase = currentPhase
        let isOpen = armsUp && legsApart
        let now = Date().timeIntervalSince1970

        // ✅ Only count when previous was closed, and pose is now open
            if prePhase == .closed && armsUp {
                if now - lastCountTime > 0.7 {
                    newCount += 1
                    lastCountTime = now
                }
                cPhase = .open
                prePhase = .open
                print("JUMPING JACKS: \(newCount) ✅ counted, previous: \(previousPhase) current: \(cPhase)")
            }
            // ✅ Reset to closed only when user returns to closed pose
            else if prePhase == .open && !armsUp {
                cPhase = .closed
                prePhase = .closed
                print("JUMPING JACKS: \(newCount) 🔄 reset to closed, previous: \(previousPhase) current: \(cPhase)")
            }
            // Not a full transition
            else {
                print("JUMPING JACKS: \(newCount) ❌ not counted, previous: \(previousPhase) current: \(cPhase)")
            }
        return (newCount, prePhase, cPhase)
    }
    
//    func pushUp(observation: HumanBodyPoseObservation,currentCount: Int, previousPhase: JumpingJackPhase, currentPhase: JumpingJackPhase) -> (Int, JumpingJackPhase,JumpingJackPhase) {
//        let joints = poseMaths.extractPoints(from: observation)
//        guard let leftEye = joints[.leftEye],
//              let rightEye = joints[.rightEye],
//              let leftWrist = joints[.leftWrist],
//              let rightWrist = joints[.rightWrist] else {
//            return (currentCount, previousPhase, currentPhase)
//        }
//        
//        let bentPushSuccess = (leftWrist.y > leftEye.y + 0.05) && (rightWrist.y > rightEye.y + 0.05)
//
//        var newCount = currentCount
//        var prePhase = previousPhase
//        let now = Date().timeIntervalSince1970
//        
//        let isDown = bentPushSuccess
//        let cPhase: JumpingJackPhase = isDown ? .closed : .open
//        
//        if prePhase == .open && cPhase == .closed{
//            newCount += 1
//            //lastCountTime = now
//            print("PUSH UPS: \(newCount) ✅ counted, previous: \(previousPhase) current: \(cPhase)")
//            prePhase = .closed
//        } else if prePhase == .closed && cPhase == .open {
//            //newCount -= 1
//            //newCount += 1
//            prePhase = .open
//            print("PUSH UPS: \(newCount) 🔄 reset to closed, previous: \(previousPhase) current: \(cPhase)")
//        } else {
//            print("PUSH UPS: \(newCount) ❌ not counted, previous: \(previousPhase) current: \(cPhase)")
//        }
//        return (newCount, prePhase, cPhase)
//    }
                  
                  
    func pushUp(observation: HumanBodyPoseObservation,currentCount: Int, previousPhase: HeadPosition, currentPhase: HeadPosition) -> (Int, HeadPosition,HeadPosition) {
            let joints = poseMaths.extractPoints(from: observation)
            guard let leftEye = joints[.leftEye],
                  let rightEye = joints[.rightEye],
                  let leftWrist = joints[.leftWrist],
                  let rightWrist = joints[.rightWrist] else {
                return (currentCount, previousPhase, currentPhase)
            }
        
        var newCount = currentCount
        var prePhase = previousPhase
        var cPhase = currentPhase
        let isDown = (leftWrist.y > leftEye.y + 0.05) && (rightWrist.y > rightEye.y + 0.05)
        //let headPos =
        let now = Date().timeIntervalSince1970
        

        // ✅ Only count when previous was closed, and pose is now open
            if prePhase == .up && isDown {
                prePhase = .down
                print("PUSH UP: \(newCount) 🔄 right: \(rightEye.y-rightWrist.y) left: \(leftEye.y-leftWrist.y)")
            }
            // ✅ Reset to closed only when user returns to closed pose
            else if prePhase == .down && !isDown {
                if now - lastCountTime > 1 {
                    newCount += 1
                    lastCountTime = now
                }
                prePhase = .up
                print("PUSH UP: \(newCount) ✅ counted, previous: \(previousPhase) current: \(cPhase)")
            }
            // Not a full transition
            else {
                print("PUSH UP: \(newCount) ❌ not counted, previous: \(previousPhase) current: \(cPhase)")
            }
        return (newCount, prePhase, cPhase)
    }
    
    func sitUp(observation: HumanBodyPoseObservation, pCount:Int) ->String{
        let joints = poseMaths.extractPoints(from: observation)
        guard let leftEye = joints[.leftEye] else {return "not found"}
        guard let rightEye = joints[.rightEye] else {return "not found"}
        guard let leftKnee = joints[.leftKnee] else {return "not found"}
        guard let rightKnee = joints[.rightKnee] else {return "not found"}
        var count = pCount
        if leftEye.y > leftKnee.y ||
            rightEye.y > rightKnee.y {
            count = count + 0
            var countString = String(count)
            print(countString)
            return countString
        } else {
            count = count + 1
            var countString = String(count)
            print(countString)
            return countString
            }
    }// end of Sit up
}
