//
//  CameraFrameHandler.swift
//  ExercisingSolo
//
//  Created by 44GOParticipant on 7/10/25.
//

import Foundation
import AVFoundation
import CoreImage
import SwiftUI
import Vision
import CoreML
import UIKit
//NEW VERSION
class FrameHandler: NSObject, ObservableObject{
    @Published var frame: CGImage?
    let captureSession = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: "sessionQueue")
    private var permissionGranted: Bool = false
    private let context = CIContext(options: [.cacheIntermediates: false])
    weak var delegate: AVCaptureVideoDataOutputSampleBufferDelegate?
    
    
    override init() {
        super.init()
        
        Task { [weak self] in
            guard let self = self else { return }
            await self.checkPermission()
            
            guard self.permissionGranted else {
                print("Camera permission denied.")
                return
            }

            self.sessionQueue.async {
                self.setUpCaptureSession()
                self.captureSession.startRunning()
            }
        }
    }

    
    func checkPermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        if status == .authorized {
            permissionGranted = true
        } else if status == .notDetermined {
            permissionGranted = await AVCaptureDevice.requestAccess(for: .video)
        } else {
            permissionGranted = false
        }

        print("Camera permission granted: \(permissionGranted)")
    }
    
    func setUpCaptureSession() {
        let videoOutput = AVCaptureVideoDataOutput()
        guard permissionGranted else { return }
        
        #if os(macOS)
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified) else {
            print("No macOS camera device found")
            return
        }
        #else
        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            print("No iOS camera device found")
            return
        }
        #endif
        
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        videoOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]
        
        videoOutput.connection(with: .video)?.videoRotationAngle = 0
    }
    
    
        
    }
    



extension FrameHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            print("Failed to convert sampleBuffer to CGImage")
            return}
        
        DispatchQueue.main.async {
            [unowned self] in
            self.frame = cgImage
        }
        delegate?.captureOutput!(output, didOutput: sampleBuffer, from: connection)
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {return nil}
        
        return cgImage
    }
}

