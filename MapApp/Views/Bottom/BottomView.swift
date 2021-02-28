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
    @Binding var directions: Bool
    @State var report = false
    @State var store = false
    @State var resturant = false
    @State var footprint = false
    let columns = [
            GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
  @State var search = ""
    @State private var landmarks: [Landmark] = [Landmark]()
    @ObservedObject var locationManager: LocationManager
    @Binding var landmark: Landmark
    @Binding var reports: [Report]
    @EnvironmentObject var userData: UserData
    @State var mapRoutes: [MKRoute] = []
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
                            resturant = true
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
                            store = true
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
                            withAnimation(.easeInOut) {
                            report = true
                            }
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
                        Button(action: {
                            withAnimation(.easeInOut) {
                            footprint = true
                            }
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "leaf")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Impact")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        
                      }
            }
       
            if report {
                Color("Light")
                ReportView(report: $report, locationManager: locationManager, reports: $reports)
            }
            if store {
                Color("Light")
                VStack {
                   
                    HStack {
                      
                        Button(action: {
                            store = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .padding()
                                .foregroundColor(Color("Green"))
                        }
                        Spacer()
                    } .padding(.horizontal)
                   
                    StoresView(locationManager: locationManager, landmark: $landmark, directions: $directions)
                        .animation(.none)
                    
                }
            }
            if resturant {
                Color("Light")
                VStack {
                   
                    HStack {
                      
                        Button(action: {
                            resturant = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .padding()
                                .foregroundColor(Color("Green"))
                        }
                        Spacer()
                    } .padding(.horizontal)
                   
                    StoresView(search: "Restaurants", locationManager: locationManager, landmark: $landmark, directions: $directions)
                        .animation(.none)
                }
                
            }
            if footprint {
                Color("Light")
                VStack {
                   
                    HStack {
                      
                        Button(action: {
                            footprint = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .padding()
                                .foregroundColor(Color("Green"))
                        }
                        Spacer()
                    } .padding(.horizontal)
                   
                  FootprintView()
                        .animation(.none)
                }
            }
            if directions {
                Color("Light")
                DirectionsView(route: $route, mapRoutes: $mapRoutes, mkRoute: $mkRoute, directions: $directions)
                    .animation(.none)
            }
    }
    }
   
}
