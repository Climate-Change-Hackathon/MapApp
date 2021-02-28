//
//  ContentView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
