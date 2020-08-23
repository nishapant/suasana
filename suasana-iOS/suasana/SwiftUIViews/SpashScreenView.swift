//
//  SpashScreenView.swift
//  suasana
//
//  Created by Nisha Pant on 8/14/20.
//  Copyright © 2020 Nisha Pant. All rights reserved.
//

import SwiftUI

struct SpashScreenView: View {
    // 1.
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            // 2.
            if self.isActive {
                // 3.
                ChatView()
            } else {
                LoadingView()
            }
        }
        // 5.
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SpashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SpashScreenView()
    }
}
