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
           
                VStack {
        Text("Trees needed to eliminate your carbon footprint from driving")
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(Color("Green"))
            Text(userData.trees.rounded(toPlaces: 1).removeZerosFromEnd())
                .font(.title)
                .bold()
                .foregroundColor(Color(.white))
                } .padding() .background(RoundedRectangle(cornerRadius: 25.0)
                                            .foregroundColor(Color("ExtraLightGreen")).padding())
            
            ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
            FootprintCardView(stat: "10%", details: "of CO2 emissions from traffic")
                FootprintCardView(stat: "2%", details: "of CO2 emissions from air travel")
                FootprintCardView(stat: "11%", details: "of CO2 emissions from deforestation")
                Spacer()
            }
            }
            Spacer()
        }
    }
}

struct FootprintView_Previews: PreviewProvider {
    static var previews: some View {
        FootprintView()
    }
}
