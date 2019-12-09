//
//  AVViewController.swift
//  Test
//
//  Created by Chuying He on 09.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI
import AVFoundation

struct AVViewController: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController
    
    /* calls this makeCoordinator() method before makeUIViewController(context:), so that you have access to the coordinator object when configuring your view controller.*/
    func makeCoordinator() -> AVViewController.Coordinator {
        return Coordinator()
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AVViewController>) -> UIViewController {
        print("makeUIViewController")
        
        getPermissionForCamera()
        setupCaptureSession()
        
        return nil
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AVViewController>) {
        print("updateUIViewController")
    }
    

    class Coordinator: NSObject {
      
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
}
