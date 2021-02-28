//
//  ShopView.swift
//  MapApp
//
//  Created by Andreas on 2/28/21.
//

import SwiftUI

struct ShopView: View {
    @State var redeem = false
    var body: some View {
        ZStack {
            Color("Light")
            VStack {
            
        ScrollView {
            ShopCard()
            ShopCard()
            ShopCard()
            ShopCard()
        }
            }
        } 
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
