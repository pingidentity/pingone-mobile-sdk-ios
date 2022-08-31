//
//  QRCapture.swift
//  SampleApp
//
//  Created by Ping Identity on 11/11/2021.
//  Copyright © 2021 Ping Identity. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRCaptureDelegate: AnyObject {

    func found(code: String)
    func failed(error: String)
}

class QRCapture: NSObject, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var delegate: QRCaptureDelegate?
    
    func stop() {
        if captureSession?.isRunning == true {
            captureSession?.stopRunning()
            print("Stopped camera scan")
        }
    }
    
    func addPreviewLayerTo(_ cameraView: UIView, withDelay: Bool, completion:@escaping (_ isDone: Bool) -> Void) {
        captureSession = AVCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer()
        let videoInput: AVCaptureDeviceInput
        
        guard var previewLayer = previewLayer else {
            completion(true)
            return
        }
        guard let captureSession = self.captureSession else {
            completion(true)
            return
        }
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            completion(true)
            return
        }
        
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            captureFailed()
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            captureFailed()
            return
        }
        
        var delay: Double = 0
        if withDelay {
            delay = 1.75
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = cameraView.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            cameraView.layer.addSublayer(previewLayer)
            
            self.startSessionInBackground {
                DispatchQueue.main.async {
                    print("Started camera scan")
                    completion(true)
                }
            }
        }
    }
    
    func startSessionInBackground(completion:@escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.captureSession?.startRunning()
            completion()
        }
    }
    
    func captureFailed() {
        delegate?.failed(error: "Your device does not support scanning a code from an item. Please use a device with a camera.")
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession?.stopRunning()
        print("Stopped camera scan")
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        delegate?.found(code: code)
    }
}
