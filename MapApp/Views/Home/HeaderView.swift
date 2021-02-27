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
    @ObservedObject var locationManager = LocationManager()
    @State var show = false
    @Binding var region: MKCoordinateRegion
    @Binding var route: Route
    @Binding var mkRoute: MKRoute
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
                ZStack {
                    
                    TextField("Search", text: $search)
                        
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundColor(Color("ExtraLightGreen")).opacity(0.8))
                    
                }  .padding()
                .onChange(of: search, perform: { value in
                    locationManager.search = search
                })
                .onChange(of: locationManager.route.stops, perform: { value in
                     route = locationManager.route
                })
                .sheet(isPresented: $locationManager.show, content: {
                    DirectionsView(route: $locationManager.route, mkRoute: $mkRoute)
                })
            } else {
                Button(action: {
                    
                }) {
                    ZStack {
                        
                        Circle()
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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


