//
//  ContentView.swift
//  Test
//
//  Created by Chuying He on 08.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showScanner = false
    @ObservedObject private var scannerObject = ScannerViewController()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // Text(self.result)
                Button(action: {
                    self.showScanner = true
                }, label: {
                    Text("Neue QR Code Scannen \(scannerObject.resultOfScanner)")
                }).sheet(isPresented: self.$showScanner) {
                    ScannerViewController()
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
