//
//  ContentView.swift
//  EssentialStacking
//
//  Created by Chuying He on 14.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Text("Hello, World!").background(Color.red)
        TabView {
            Text("VStack")
                .font(.title)
                .tabItem({ VStackShow() })
                .tag(0)
            Text("HStack")
                .font(.title)
                .tabItem({ HStackShow() })
                .tag(1)
            Text("ZStack")
                .font(.title)
                .tabItem({ ZStackShow() })
                .tag(2)
            Text("MIX")
                .font(.title)
                .tabItem({ StackShow() })
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
