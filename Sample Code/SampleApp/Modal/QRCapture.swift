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

    var captureSession: AVCaptureSession!
    var previewLayer:   AVCaptureVideoPreviewLayer!
    weak var delegate:  QRCaptureDelegate?
    
    func stop(){
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func start(){
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    func addPreviewLayerTo(_ cameraView: UIView, withDelay: Bool, completion:@escaping (_ isDone: Bool) -> Void) {
        captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            captureFailed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            captureFailed()
            return
        }
        
        var delay : Double = 0
        if withDelay {
            delay = 1.75
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = cameraView.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            cameraView.layer.addSublayer(self.previewLayer)
            self.captureSession.startRunning()
            completion(true)
        }
    }
    
    func captureFailed() {
        delegate?.failed(error: "Your device does not support scanning a code from an item. Please use a device with a camera.")
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
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
