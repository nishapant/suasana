//
//  ChatView.swift
//  suasana
//
//  Created by Nisha Pant on 8/10/20.
//  Copyright © 2020 Nisha Pant. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @State var typingMessage: String = ""
    @State private var messages = [Message]()

    
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableView.appearance().tableFooterView = UIView()
    }
    
    func sendMessage() {
        let messageToSend = Message(content: typingMessage, user: User(name: "nisha", isComputer: false))
        messages.append(messageToSend)
        loadData(text: typingMessage)
        typingMessage = ""
    }
    
    func loadData(text:String) {
        let get_url = URL(string: "http://localhost:4242/dialogflow")
        guard let requestUrl = get_url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let parameters = PacketPOST(text: text)

        do {
           // Set HTTP Request Body
           let jsonData = try JSONEncoder().encode(parameters)
           request.httpBody = jsonData
        } catch {
            print(error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(PacketReceived.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                    
                        self.messages.append(Message(content: decodedResponse.response, user: User(name: "nisha", isComputer: true)))
                    }

                    // everything is good, so we can exit
                    return
                }
            }
        }.resume()

        
    }


    var body: some View {
        NavigationView {
            VStack {
               List {
                   ForEach(messages, id: \.self) { msg in
                        MessageView(currentMessage: Message(content: msg.content, user: msg.user), isRealUser: !msg.user.isComputer)
                   }
               }
               HStack {
                   TextField("Message...", text: $typingMessage)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .frame(minHeight: CGFloat(30))
                    Button(action: sendMessage) {
                        Text("Send")
                     }
                }.frame(minHeight: CGFloat(50)).padding()
            }
            .navigationBarTitle(Text("Suasana"), displayMode: .inline)
        }
        
    }
}



struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
