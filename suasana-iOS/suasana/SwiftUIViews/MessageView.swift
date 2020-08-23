//
//  MessageView.swift
//  suasana
//
//  Created by Nisha Pant on 8/10/20.
//  Copyright © 2020 Nisha Pant. All rights reserved.
//

import SwiftUI

struct MessageView : View {
    var currentMessage: Message
    var isRealUser: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !isRealUser {
                Image("suasana-icon")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2))
            } else {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.content, isRealUser: isRealUser)
        }
    }
}

