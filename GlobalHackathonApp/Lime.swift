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
        let formattedPhone = phoneInput.replacingOccurrences(of: "-", with: "")
        let url = URL(string: baseURL + "/v1/login?phone=%2B1" + formattedPhone)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                onCompletion(httpResponse.statusCode == 200)
            }
        }
        task.resume()
    }
    
    func verifyLimeCode(code: String, phoneInput: String, onDone: (String, HTTPCookie) -> Void) {
        let formattedPhone = phoneInput.replacingOccurrences(of: "-", with: "")
        let data: [String: String] = [
            "login_code": code,
            "phone": formattedPhone
        ]
        var request = URLRequest(url: URL(string: baseURL + "/v1/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: data)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let url = response?.url,
                  let httpResponse = response as? HTTPURLResponse,
                  let fields = httpResponse.allHeaderFields as? [String: String]
            else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            do {
                var token: String = ""
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    token = json["token"] as! String
                }
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
                var cookie = cookies.first(where: {$0.name == "_limebike-web_session"})
                onDone(token, cookie!)
            } catch {
                print("JSONSerialization error:", error)
            }
        }
        task.resume()
    }
    
    func getRecentRides(token: String) {
        
    }
}
