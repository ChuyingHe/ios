//
//  ScannerViewController.swift
//  Test
//
//  Created by Chuying He on 10.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI
import AVFoundation
import UIKit

final class ScannerViewController: UIViewController, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published public var resultOfScanner: String
       
    private init(result: String) {
        self.resultOfScanner = result
    }
    
    required init?(coder: NSCoder) {
        print(coder) // what's that
    }
    
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        captureSession = AVCaptureSession()
        
        // unwrap
        guard let captureSession = captureSession else {
            print("error: captureSession doesnt exits")
            return
        }
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if(captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if(captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            /// Sets the receiver's delegate that will accept metadata objects and dispatch queue on which the delegate will be called.
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        guard let previewLayer = previewLayer else {
            print("error: previewLayer doesnt exits")
            return
        }
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        previewLayer.frame = CGRect(x: 0.1*screenWidth, y: 0.1*screenWidth, width: 0.8*screenWidth, height: 0.8*screenWidth)
        // previewLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        // @TODO: WHY ITS NOT RECTANGLE? weird...
        print("screen width:", screenWidth)
        print("screen width:", screenHeight)
        print("preview's frame: ", previewLayer.frame)
 
        // previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // run session
        if (captureSession?.isRunning == false) {
            captureSession?.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // end session
        if (captureSession?.isRunning == true) {
            captureSession?.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("Tell Delegate: we captured a new Metadata from the Output!")
        
        captureSession?.stopRunning()    // stop video
        
        if let metadata = metadataObjects.first {
            guard let metadata = metadata as? AVMetadataMachineReadableCodeObject else {
                print("no readable data")
                return
            }
            guard let stringValue = metadata.stringValue else {
                print("no string value from readable data")
                
                return
            }
            resultOfScanner = stringValue
            
            // @TODO: what happend then?
            print("stringValue: \(stringValue)")
            
            print("resultOfScanner: \(resultOfScanner)")
        }
        
        dismiss(animated: true)
    }
    
    func failed() {
        let alert = UIAlertController(title: "Scanning failed", message: "Please use a device with a camera", preferredStyle: .alert)
        present(alert, animated: true)
        captureSession = nil    // default value
    }
    
}

extension ScannerViewController: UIViewControllerRepresentable {
    public typealias UIViewControllerType = ScannerViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerViewController>) -> ScannerViewController {
        
        return ScannerViewController(result: resultOfScanner)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: UIViewControllerRepresentableContext<ScannerViewController>) {
        
    }
}
