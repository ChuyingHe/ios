//
//  QRCodeScanner.swift
//  Test
//
//  Created by Chuying He on 08.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI
import AVFoundation


struct QRCodeScanner {
    @Binding var isShown: Bool
    @Binding var image: Image?
}

extension QRCodeScanner: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<QRCodeScanner>) -> UIViewController {
        
        print("makeUIViewController")

        
        /* UIImagePickerController */
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = .camera
        
        return controller
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<QRCodeScanner>) {
        
        print("updateUIViewController")
    }
    
    
    
    func makeCoordinator() -> QRCodeScanner.Coordinator {
        print("makeCoordinator")

        return Coordinator(isShown: $isShown, image: $image)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        @Binding var isShown: Bool
        @Binding var image: Image?
        
        init(isShown: Binding<Bool>, image: Binding<Image?>) {
            print("Coordinator")

            _isShown = isShown
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            /*
            if let selectedImage = info[.originalImage] as? UIImage {
                print(selectedImage)
            }
 */
            
            guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            image = Image(uiImage: unwrapImage)
            isShown = false

        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}

