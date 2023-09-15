//
//  ScannerView.swift
//  GlobalHackathonApp
//
//  Created by Celeste Roselli on 9/14/23.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    
    var body: some View {
        VStack {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Success") { response in
                switch response {
                case .success(let result):
                    if (result.string) == "Success" {
                        print("We did it!")
                        //trigger a modal to pop out saying that points were added
                    }
                case .failure(let error):
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
