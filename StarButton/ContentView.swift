//
//  ContentView.swift
//  StarButton
//
//  Created by 程信傑 on 2022/12/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            StarButton()
                .fixedSize() // 固定在最佳尺寸，不要延伸到整個畫面
                .preferredColorScheme(.light)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
