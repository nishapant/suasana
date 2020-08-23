//
//  HTTPRequests.swift
//  suasana
//
//  Created by Nisha Pant on 8/12/20.
//  Copyright © 2020 Nisha Pant. All rights reserved.
//

import Foundation

var info: String?

func createPOSTRequest() {
    let get_url = URL(string: "http://localhost:4242/dialogflow")
        guard let requestUrl = get_url else { fatalError() }

        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let parameters = PacketPOST(text: "i want to quit")

        do {
            // Set HTTP Request Body
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            print(error)
        }
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }

            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("\(dataString)")

            }

            // Print the status code (should be a 202 if everything went well)
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)

            }
        }
    
        task.resume()
       
}
