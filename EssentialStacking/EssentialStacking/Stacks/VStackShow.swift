//
//  VStackShow.swift
//  EssentialStacking
//
//  Created by Chuying He on 14.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct VStackShow: View {
    var body: some View {
        VStack {
            // Spacer().background(Color.orange)
            /* This doesn't work until you
                - give it a frame-with-width in VStack
                OR
                - give it a frame-with-height in HStack
             */
            
            Text("LBTA top").background(Color.red)
            Spacer().frame(width: 10).background(Color.orange)
            Text("LBTA bottom").background(Color.red)
        }.background(Color.blue)
    }
}

struct VStackShow_Previews: PreviewProvider {
    static var previews: some View {
        VStackShow()
    }
}
