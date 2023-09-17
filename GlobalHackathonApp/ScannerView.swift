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
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    @State private var counter: Int = 0
    @Binding var points: Int
    @AppStorage("date") var date: Int = 0
    @State var scanner_alert: Bool = false
    @Binding var name: String
    @Binding var alert: Bool
    @Binding var num_uber: Int
    @Binding var num_lime: Int
    @State var showDetail: Bool = false
    
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
                if check_time() {
                    CodeScannerView(codeTypes: [.qr], scanMode: .oncePerCode, simulatedData: "Success") { response in
                        switch response {
                        case .success(let result):
                            if (result.string) == "Success" {
                                print("Scanner is locked out for 5 minutes to prevent double-scanning")
                                scanner_alert = true
                                date = Int(UInt64((Date().timeIntervalSince1970)))
                                points += 3
                                
                            }
                        case .failure(let error):
                            //handles error
                            print(error.localizedDescription)
                        }
                    }
                } else if check_time() == false {
                   
                    Text("Code scanned!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        // dont delete          counter += 1
                }
            }.alert(isPresented: $scanner_alert) {
                
                Alert(title: Text("You took public transit!"), message: Text("You've been rewarded 3 points"), dismissButton: .default(Text("Got it!"))) }
        }.navigationTitle("QR Scanner")
            .confettiCannon(counter: $counter, radius: 500.0)
    }
}

//struct ScannerView_Previews: PreviewProvider {
//  @State var points: Int = 3
//  static var previews: some View {
//      ScannerView(points: $points)
//  }
//}
