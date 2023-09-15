//
//  ScannerView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import CodeScanner


struct ScannerView: View {
    
    @State var last_date = Date()
    
    var body: some View {
        
        VStack {
            Text("QR Scanner")
                .font(.title)
                .padding()
            CodeScannerView(codeTypes: [.qr], simulatedData: "Success") { response in
                switch response {
                case .success(let result):
                    if (result.string) == "Success" {
                        print("Points added!")
                        //trigger a modal to pop out saying that points were added
                        struct popupReward {
                            static var popupRewardNextLaunch = 1
                        }
                    }
                case .failure(let error):
                    //handles error
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
