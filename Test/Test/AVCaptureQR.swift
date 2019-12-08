//
//  AVCaptureQR.swift
//  Test
//
//  Created by Chuying He on 08.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI
import AVFoundation

// real content
class AVCaptureQR: UIView {
    override init(frame: CGRect) {
        print("init avcaptureqr")
        super.init(frame: frame)
        getPermissionForCamera()
        setupCaptureSession()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    func setupCaptureSession() {
        print("setupCaptureSession")
        

        /* create session */
        let captureSession = AVCaptureSession()
        
        captureSession.beginConfiguration()

        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        /* add input to session */
        do {
            let videoInput = try AVCaptureDeviceInput(device: device)
            
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            }
        } catch {
            print(error)
        }
        
        /* add output to session */
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        
        
        /*
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        */
        
        print("capture session:", captureSession)
        
        /* add preview lazer */
        let previewLayer = AVCaptureVideoPreviewLayer()
        previewLayer.session = captureSession
        
        /* run the session */
        captureSession.startRunning()

    }
    
    func getPermissionForCamera() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                self.setupCaptureSession()
            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        self.setupCaptureSession()
                    }
                }
            case .denied: // The user has previously denied access.
                return
            case .restricted: // The user can't grant access due to restrictions.
                return
            default:
                return
        }
    }

    class PreviewView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        
        /// Convenience wrapper to get layer as its statically known type.
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }

}

// swiftUI container: to include real AVCapture -
struct AVCaptureQRContainer: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: UIViewRepresentableContext<AVCaptureQRContainer>) -> UIView {
        print("makeUIView for AV Capture")
        /*
        let windowSize: CGSize = UIScreen.main.bounds.size
        let scanSize:CGSize = CGSize(width: windowSize*3.0/4.0, height: windowSize*3.0/4.0)
        */
        return  AVCaptureQR(frame: .zero)
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AVCaptureQRContainer>) {
        print("update")
    }
}
