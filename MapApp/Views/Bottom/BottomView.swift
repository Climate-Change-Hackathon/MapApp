//
//  BottomView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit

struct BottomView: View {
    @Binding var route: Route
    @Binding var mkRoute: MKRoute
    @State var directions = false
    
    let columns = [
            GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
  
    var body: some View {
        ZStack {
            ScrollView {
                      LazyVGrid(columns: columns, spacing: 20) {
                        
                        Button(action: {
                            directions = true
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Directions")
                                    .foregroundColor(Color("LightGreen"))
                                    .font(.headline)
                            }
                        }
                        Button(action: {
                            
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Directions")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        }
                        Button(action: {
                            
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Directions")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        }
                        Button(action: {
                            
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "xmark")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Directions")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        }
                      }
            }
        if directions {
            DirectionsView(route: $route, mkRoute: $mkRoute, directions: $directions)
        }
    }
    }
}
