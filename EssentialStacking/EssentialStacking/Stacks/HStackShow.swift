//
//  HStackShow.swift
//  EssentialStacking
//
//  Created by Chuying He on 14.12.19.
//  Copyright © 2019 Chuying He. All rights reserved.
//

import SwiftUI

struct HStackShow: View {
    var body: some View {
        HStack {
            Text("LEFT")
            Spacer().frame(height: 5).background(Color.green)
            Text("RIGHT")
        }.background(Color.yellow)
    }
}

struct HStackShow_Previews: PreviewProvider {
    static var previews: some View {
        HStackShow()
    }
}
