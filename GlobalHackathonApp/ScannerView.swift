//
//  ScannerView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import CodeScanner


struct ScannerView: View {
    @Binding var points: Int
    
    var body: some View {
        NavigationView {
            VStack {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Success") { response in
                    switch response {
                    case .success(let result):
                        if (result.string) == "Success" {
                            print("Points added!")
                            points += 1
                            //trigger a modal to pop out saying that points were added
                            
                        }
                    case .failure(let error):
                        //handles error
                        print(error.localizedDescription)
                    }
                }
            }
        }.navigationTitle("QR Scanner")
    }
}

//struct ScannerView_Previews: PreviewProvider {
  //  @State var points: Int = 3
  //  static var previews: some View {
  //      ScannerView(points: $points)
  //  }
//}
