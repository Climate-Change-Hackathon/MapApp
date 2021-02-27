//
//  HomeView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        ZStack {
            
            MapExample()
                .ignoresSafeArea()
            VStack {
                HeaderView()
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
