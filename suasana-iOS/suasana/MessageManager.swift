//
//  MessageManager.swift
//  suasana
//
//  Created by Nisha Pant on 8/10/20.
//  Copyright © 2020 Nisha Pant. All rights reserved.
//

import Foundation

class MessageManager {
    private var messages: [Message] = []

    
    private init() {
        messages = []
    }
    
    static let shared = MessageManager()

    
    func addMessage(msg: Message) {
        messages.append(msg)
    }
    
    func getMessages() -> [Message] {
        return messages
    }
}
