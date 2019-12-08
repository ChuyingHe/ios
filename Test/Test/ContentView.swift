//
//  ContentView.swift
//  Test
//
//  Created by Chuying He on 08.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var image: Image? = nil
    @State var isShown = false
    @State var isShownAV = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isShown.toggle()
                }) {
                    Text("Choose photos")
                }
                
                Button(action: {
                    self.isShownAV.toggle()
                }) {
                    Text("AV Session")
                }
            }
            
            image?.resizable()
              .frame(width: 250, height: 250)
              .clipShape(Circle())
              .overlay(Circle().stroke(Color.white, lineWidth: 4))
              .shadow(radius: 10)
            
            
            if (isShown) {
                QRCodeScanner(isShown: $isShown, image: $image)
            }
            
            if (isShownAV) {
                AVCaptureQRContainer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
