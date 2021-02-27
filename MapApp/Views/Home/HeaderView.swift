//
//  HeaderView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI
import MapKit
struct HeaderView: View {
    @State var isSearching = false
    @State var search = ""
    @ObservedObject var locationManager: LocationManager
   
    @Binding var region: MKCoordinateRegion
    @Binding var route: Route
    @Binding var mkRoute: MKRoute
    @State var typing = false
    @Binding var show: Bool
    var body: some View {
        
        HStack {
            if !isSearching {
            Button(action: {
                
            }) {
                ZStack {
                    
                    Circle()
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("ExtraLightGreen"))
                        .opacity(0.8)
                    Image(systemName: "sidebar.left")
                        .foregroundColor(Color("Green"))
                        .font(.headline)
                }
            }   .padding()
            Spacer()
            }
            Button(action: {
                withAnimation(.easeInOut) {
                    isSearching.toggle()
                    if !isSearching {
                        locationManager.buildRoute()
                        region = locationManager.currentRegion ?? MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
                            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                        )
                    }
                }
            }) {
                ZStack {
                    
                    Circle()
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("ExtraLightGreen"))
                        .opacity(0.8)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Green"))
                        .font(.headline)
                        .padding()
                }
            }
            if isSearching {
                VStack {
                    
                    TextField("Search", text: $search)
                        
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundColor(Color("ExtraLightGreen")).opacity(0.8))
                    if typing {
                        
                        LocList(region: $region, route: $route, mkRoute: $mkRoute)
                            .frame(height: 300)
                            .cornerRadius(25)
                    }
                }  .padding()
                .onChange(of: search, perform: { value in
                    locationManager.search = search
                                   
                                   typing = true
                                   if search == "" { typing.toggle() }
                               })
                .onChange(of: locationManager.route.stops, perform: { value in
                     route = locationManager.route
                })
                .onChange(of: locationManager.show, perform: { value in
                     show = locationManager.show
                })
            } else {
                Button(action: {
                    
                }) {
                    ZStack {
                        
                        Circle()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(Color("ExtraLightGreen"))
                            .opacity(0.8)
                        Image(systemName: "gear")
                            .foregroundColor(Color("Green"))
                            .font(.headline)
                            .padding()
                    }
                }
             
            }
        }
    }
}


