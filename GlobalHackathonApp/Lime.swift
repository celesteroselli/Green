//
//  Lime.swift
//  GlobalHackathonApp
//
//  Created by Liam Loughead on 9/15/23.
//  API documentation: https://github.com/ubahnverleih/WoBike/blob/master/Lime.md
//

import Foundation

struct Lime {
    var baseURL: String = "https://web-production.lime.bike/api/rider"
    var phoneNumberRegex: String = "^[0-9]{3}+-[0-9]{4}+-[0-9]{3}+"
    
    func sendLimeConfCode(phoneInput: String, onCompletion: @escaping (Bool) -> Void) {
        var formattedPhone = phoneInput.replacingOccurrences(of: "-", with: "")
        var url = URL(string: baseURL + "/v1/login?phone=%2B1" + formattedPhone)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                onCompletion(httpResponse.statusCode == 200)
            }
        }
        task.resume()
    }
}
