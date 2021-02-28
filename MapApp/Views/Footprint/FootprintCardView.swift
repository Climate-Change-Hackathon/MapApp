//
//  FootprintCardView.swift
//  MapApp
//
//  Created by Andreas on 2/28/21.
//

import SwiftUI

struct FootprintCardView: View {
    @State var stat = ""
    @State var details = ""
    var body: some View {
       
            
                
            VStack {
                HStack {
                Text(stat)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                Text(details)
                    .font(.footnote)
                    .foregroundColor(Color("Green"))
                    .multilineTextAlignment(.leading)
                    Spacer()
            }
            } .padding()
                .background(RoundedRectangle(cornerRadius: 25.0)
                                .foregroundColor(Color("ExtraLightGreen")))
    }
}

struct FootprintCardView_Previews: PreviewProvider {
    static var previews: some View {
        FootprintCardView()
    }
}
