//
//  HomeView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI
import MapKit
struct HomeView: View {
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        @State var route = Route(origin: MKMapItem(), stops: [MKMapItem]())
    @State var mkRoute = MKRoute()
    var body: some View {
        ZStack {
            
            MapView(region: $region, route: $mkRoute)
                .ignoresSafeArea()
            VStack {
                HeaderView(region: $region, route: $route, mkRoute: $mkRoute)
                Spacer()
            }
        }
    }
}

