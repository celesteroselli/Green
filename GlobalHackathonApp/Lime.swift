//
//  Lime.swift
//  GlobalHackathonApp
//
//  Created by Liam Loughead on 9/15/23.
//  API documentation: https://github.com/ubahnverleih/WoBike/blob/master/Lime.md
//

import Foundation

struct VerifyCodeSendModel: Codable {
    var login_code: String = ""
    var phone: String = ""
}

struct Lime {
    var baseURL: String = "https://web-production.lime.bike/api/rider"
    var phoneNumberRegex: String = "^[0-9]{3}+-[0-9]{4}+-[0-9]{3}+"
    
    func sendLimeConfCode(phoneInput: String, onCompletion: @escaping (Bool) -> Void) {
        let formattedPhone = phoneInput.replacingOccurrences(of: "-", with: "")
        let url = URL(string: baseURL + "/v1/login?phone=%2B1" + formattedPhone)!
        print("Sending \(url.absoluteString)")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                if (httpResponse.statusCode != 200) {
                    print(httpResponse.allHeaderFields)
                }
                onCompletion(httpResponse.statusCode == 200)
            }
        }
        task.resume()
    }
    
    func verifyLimeCode(code: String, phoneInput: String, onDone: @escaping (String, String) -> Void) {
        let formattedPhone = phoneInput.replacingOccurrences(of: "-", with: "")
        var data: VerifyCodeSendModel = VerifyCodeSendModel()
        data.login_code = code
        data.phone = "+1" + formattedPhone
        print(data)
        var request = URLRequest(url: URL(string: baseURL + "/v1/login")!)
        request.httpMethod = "POST"
        let toSendStr = "{\"login_code\": \"\(code)\", \"phone\": \"+1\(formattedPhone)\"}"
        print(toSendStr)
        request.httpBody = toSendStr.data(using: .ascii)
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
                    print(httpResponse.statusCode)
                    print(json)
                    token = json["token"] as! String
                }
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
                var cookie = cookies.first(where: {$0.name == "_limebike-web_session"})
                onDone(token, cookie!.value)
            } catch {
                print("JSONSerialization error:", error)
            }
        }
        task.resume()
    }
    
    func getRecentRides(token: String) {
        
    }
}
