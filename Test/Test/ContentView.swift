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
    @State private var result: String = ""
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // Text(self.result)
                Button(action: {
                    self.showScanner = true
                }, label: {
                    Text("Neue QR Code Scannen")
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
