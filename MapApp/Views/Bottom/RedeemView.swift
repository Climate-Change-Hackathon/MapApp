//
//  RedeemView.swift
//  MapApp
//
//  Created by Andreas on 2/28/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct RedeemView: View {
    @EnvironmentObject var userData: UserData
    @State var code = ""
    @State var error = false
    var body: some View {
        ZStack {
        VStack {
        HStack {
            Spacer()
        Text("Enter your ridesharing code from your driver to earn Carbon Coins!")
            .font(.headline)
            .padding()
            .multilineTextAlignment(.trailing)
        }
            
            TextField("Enter Code", text: $code)
                .padding()
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(Color("ExtraLightGreen")).padding(.horizontal))
            HStack {
                Spacer()
            Button(action: {
                checkCode()
            }) {
                Text("Enter")
                    .foregroundColor(Color(.white))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(Color("ExtraLightGreen")))
            }
               
            } .padding()
        }
            if error {
                Color("Light")
                
            VStack {
                HStack {
                Button(action: {
                    error = false
                }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color("Green"))
                }
                    Spacer()
                }
                Spacer()
                Text("We've hit an error :(")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("Green"))
                Spacer()
            } .padding()
    }
        }
    }
    func checkCode() {
        let db = Firestore.firestore()
        if code != "" {
        let docRef = db.collection("RideShare").document(code)
        docRef.getDocument { (document, error) in
            
            if !((document?.exists) != nil) {
                userData.carboncoins += 10
            } else {
                self.error = true
            }
            
        }
        } else {
            self.error = true
        }
        if (error != nil) {
            self.error = true
        }
    }
}

struct RedeemView_Previews: PreviewProvider {
    static var previews: some View {
        RedeemView()
    }
}
