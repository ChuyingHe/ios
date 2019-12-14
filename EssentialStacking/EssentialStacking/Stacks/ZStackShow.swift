//
//  ZStackShow.swift
//  EssentialStacking
//
//  Created by Chuying He on 14.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct ZStackShow: View {
    var body: some View {
        ZStack {
            HStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Spacer().frame(height: 5).background(Color.green)
            }
        }
    }
}

struct ZStackShow_Previews: PreviewProvider {
    static var previews: some View {
        ZStackShow()
    }
}
