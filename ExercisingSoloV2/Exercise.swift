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

class Exercise{
    let poseMaths = PoseEstimationViewModel()
    
    func jumpingJack(observation: HumanBodyPoseObservation){
        let joints = poseMaths.extractPoints(from: observation)
        /*leftWrist =
        rightWrist =
        leftElbow =
        rightElbow =*/
        
        
    }
    
    func plank(){
        
    }
    
    func pushUp(){
        
    }
    
    func sitUp(){
        
    }
}
