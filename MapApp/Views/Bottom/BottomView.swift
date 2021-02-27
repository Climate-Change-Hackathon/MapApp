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
    @State var report = false
    let columns = [
            GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
  
    var body: some View {
        ZStack {
        
                      LazyVGrid(columns: columns, spacing: 20) {
                        
                        Button(action: {
                            directions = true
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "arrow.up")
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
                                Image(systemName: "building.2")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Restaurants")
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
                                Image(systemName: "building")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Stores")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        }
                        Button(action: {
                            report = true
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "mappin")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Report")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        
                      }
            }
        if directions {
            DirectionsView(route: $route, mkRoute: $mkRoute, directions: $directions)
        }
            if report {
                ReportView(report: $report)
            }
    }
    }
}
