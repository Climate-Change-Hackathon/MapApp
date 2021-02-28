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
           
                Spacer()
               
                Text(text)
                    .multilineTextAlignment(.leading)
                  
            } .padding()
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Buy")
                            .foregroundColor(Color("LightGreen"))
                    }
                } .padding()
        }
        }
    }
}

struct ShopCard_Previews: PreviewProvider {
    static var previews: some View {
        ShopCard()
    }
}
