//
//  StackShow.swift
//  EssentialStacking
//
//  Created by Chuying He on 14.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct StackShow: View {
    var body: some View {
        ZStack {
            Color.green
            /*
             pure "Color.green"
             - wont show cause the VStack is one layer upon it > remove the VStack{}.background(Color.pink) > then it shows
             - wont fill the edge area with green cause it doesnt works like that - see example below
             */
            
            Color.green.edgesIgnoringSafeArea(.all)
            /// this fill out the edge area
            
            
            VStack {
                HStack {
                    Text("Top").padding(16).foregroundColor(Color.white).background(Color.purple)
                    Spacer().frame(height: 5).background(Color.red)
                }
                Spacer().frame(width: 5).background(Color.white)
                HStack {
                    Spacer().frame(height: 5).background(Color.red)
                    Text("Buttom").padding(16).foregroundColor(Color.white).background(Color.purple)
                }
            }.background(Color.pink)
            
        }
    }
}

struct StackShow_Previews: PreviewProvider {
    static var previews: some View {
        StackShow()
    }
}
