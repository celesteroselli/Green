//
//  ScannerView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import CodeScanner
import ConfettiSwiftUI

struct ScannerView: View {
    //declares variables, and binds other stored variables from HomePage
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    @Binding var points: Int
    @AppStorage("date") var date: Int = 0
    @State var scanner_alert: Bool = false
    @Binding var name: String
    @Binding var alert: Bool
    @Binding var num_uber: Int
    @Binding var num_lime: Int
    @State var showDetail: Bool = false
    
    //checks if last time stored was more than 300 seconds (5 minutes) ago
    //used to stop people from scanning the same code twice
    //if current time is less than 300 seconds from the last time accessed, returns false
    //if not, returns true
    func check_time() -> Bool {
        let now: Int = Int(UInt64((Date().timeIntervalSince1970)))
        if now < (date + 300) {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {

        NavigationView {
            VStack {
                //if check_time() returns true (it has been more than 5 minutes since last used), show the CodeScannerView
                if check_time() {
                    //CodeScannerView - imported view from QR scanning package
                    //scanMode: .oncePerCode to show lock out after being scanned once
                    //simulatedDate shows "Success", to add points when in Simulator mode and camera is not available
                    CodeScannerView(codeTypes: [.qr], scanMode: .oncePerCode, simulatedData: "Success") { response in
                        switch response {
                        case .success(let result):
                            //if succesful scan, trigger an alert telling user that points have been added, and set last accessed date to now
                            //then add points
                            if (result.string) == "Success" {
                                print("Scanner is locked out for 5 minutes to prevent double-scanning")
                                scanner_alert = true
                                date = Int(UInt64((Date().timeIntervalSince1970)))
                                points += 3
                                
                            }
                        case .failure(let error):
                            //handles errors
                            print(error.localizedDescription)
                        }
                    }
                    //if check_time() == false (it has not been 5 minutes since last used)
                } else if check_time() == false {
                   
                    //show screen saying "Code scanned!"
                    Text("Code scanned!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                //set up settings for alert when QR code is succesfully scanned
            }.alert(isPresented: $scanner_alert) {
                
                Alert(title: Text("You took public transit!"), message: Text("You've been rewarded 3 points"), dismissButton: .default(Text("Got it!"))) }
        }.navigationTitle("QR Scanner")
    }
}
