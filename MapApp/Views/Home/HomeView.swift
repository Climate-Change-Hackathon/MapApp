//
//  HomeView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI
import MapKit
import BottomSheet
struct HomeView: View {
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    @State var route = Route(origin: MKMapItem(), stops: [MKMapItem]())
    @ObservedObject var locationManager = LocationManager()
    @State var mkRoute = MKRoute()
    @State var show = false
    @State var speed = 0.0
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                MapView(region: $region, route: $mkRoute)
                    .ignoresSafeArea()
                    .onAppear() {
                        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            speed = Double(locationManager.speed).rounded(toPlaces: 0)
                        }
                    }
                VStack {
                    HeaderView(locationManager: locationManager, region: $region, route: $route, mkRoute: $mkRoute, show: $show)
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("ExtraLightGreen"))
                                .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text(speed.removeZerosFromEnd())
                               
                        }
                        
                        Spacer()
                    } .padding()
                    Spacer()
                   
                }
                BottomSheetView(
                    isOpen: self.$show,
                    maxHeight: geo.size.height * 0.7
                ) {
                    BottomView(route: $locationManager.route, mkRoute: $mkRoute)
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

