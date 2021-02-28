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
    @ObservedObject var locationManager = LocationManager()
    @State var mkRoute = MKRoute()
    @State var show = false
    @State var speed = 0.0
    @State var landmark: Landmark = Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)))
    @State var reports = [Report]()
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                    
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        region = locationManager.currentRegion ?? MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
                            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                        }
                    }
                MapView(region: $region, route: $mkRoute, reports: $reports)
                    .ignoresSafeArea()
                   
                VStack {
                    HeaderView(locationManager: locationManager, region: $region, route: $route, mkRoute: $mkRoute, show: $show, landmark: $landmark)
                  
                    Spacer()
                   
                }
                BottomSheetView(
                    isOpen: self.$show,
                    maxHeight: geo.size.height * 0.7
                ) {
                    BottomView(route: $locationManager.route, mkRoute: $mkRoute, locationManager: locationManager, landmark: $landmark, reports: $reports)
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

