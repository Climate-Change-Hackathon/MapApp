//
//  ShopCard.swift
//  MapApp
//
//  Created by Andreas on 2/28/21.
//

import SwiftUI

struct ShopCard: View {
    @State var image = "carboncoin"
    @State var text = "Exmaple product"
    var body: some View {
        ZStack {
            VStack {
            HStack {
       Image(image)
        .resizable()
        .scaledToFit()
        .padding()
                Spacer()
               
                Text(text)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .foregroundColor(Color("Green"))
                    .padding()
                   
            } .padding()
                VStack {
                    HStack {
                        Spacer()
                    Text("1000 Carbon Coins")
                        .foregroundColor(Color("LightGreen"))
                        .font(.footnote)
                    } .padding(.horizontal)
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Buy")
                            .foregroundColor(Color("LightGreen"))
                            .bold()
                    }
                } .padding()
                }
        }
        }
    }
}

struct ShopCard_Previews: PreviewProvider {
    static var previews: some View {
        ShopCard()
    }
}
