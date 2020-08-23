//
//  ContentMessageView.swift
//  suasana
//
//  Created by Nisha Pant on 8/10/20.
//  Copyright © 2020 Nisha Pant. All rights reserved.
//

import SwiftUI

struct ContentMessageView: View {
    var contentMessage: String
    var isRealUser: Bool

    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isRealUser ? Color.black : Color.white)
            .background(isRealUser ? Color(UIColor(red: 247/255, green: 223/255, blue: 151/255, alpha: 1.0)) : Color(UIColor(red: 65/255, green: 159/255, blue: 130/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}
