//
//  FootprintView.swift
//  MapApp
//
//  Created by Andreas on 2/28/21.
//

import SwiftUI

struct FootprintView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        VStack {
       
        Text("Trees needed to eliminate your carbon footprint from driving")
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(Color("LightGreen"))
            Text(userData.trees.rounded(toPlaces: 1).removeZerosFromEnd())
                .font(.title)
                .bold()
                .foregroundColor(Color("Green"))
        }
    }
}

struct FootprintView_Previews: PreviewProvider {
    static var previews: some View {
        FootprintView()
    }
}
