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
        //Format the phone number, same as above
        let formattedPhone = phoneInput.replacingOccurrences(of: "-", with: "")
        //Prepare the request, same endpoint as above but different method
        var request = URLRequest(url: URL(string: baseURL + "/v1/login")!)
        request.httpMethod = "POST"
        
        //Prepare the JSON string. A struct would make more sense but they don't encode into JSON correctly, so the string is manually created here.
        let toSendStr = "{\"login_code\": \"\(code)\", \"phone\": \"+1\(formattedPhone)\"}"
        print(toSendStr)
        request.httpBody = toSendStr.data(using: .ascii)
        
        //Request and callback
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //Declare response object variables for later
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
                //Get the token from the JSON; The token should exist
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(httpResponse.statusCode)
                    print(json)
                    if let t = json["token"] as? String {
                        token = t
                    } else {
                        print("Lime Verify code: JSON response invalid")
                        return
                    }
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
    
    func getLastRideTime(token: String, cookie: String, onDone: @escaping (Double) -> Void) {
        var request = URLRequest(url: URL(string: baseURL + "/v1/views/ride_history?page_limit=1")!)
        request.setValue(cookie, forHTTPHeaderField: "Authorization")
        
        if let cookie = HTTPCookie(properties: [
            .domain: request.url?.host()!,
            .path: "/",
            .name: "_limebike-web_session",
            .value: cookie,
            .secure: "FALSE",
            .discard: "TRUE"
        ]) {
            HTTPCookieStorage.shared.setCookie(cookie)
            print("Cookie inserted: \(cookie)")
        }
        
        print("Sending \(String(describing: request.url?.absoluteString))")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse
                else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(httpResponse.statusCode)
                        //Go through the object, and get the trips array
                        let data: [String : Any] = json["data"] as! [String : Any]
                        let attributes: [String : Any] = data["attributes"] as! [String : Any]
                        let trips: [[String : Any]] = attributes["trips"] as! [[String : Any]]
                        //If there are no trips, then just return 0
                        if (trips.count == 0) {
                            onDone(0.0)
                        } else {
                            //Otherwise, return the last ride time as a timestamp
                            onDone(trips[0]["time"] as! Double)
                        }
                    }
                } catch {
                    print("JSONSerialization error:", error)
                }
            }
        }
        task.resume()
    }
}
