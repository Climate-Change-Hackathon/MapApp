//
//  SwiftUIView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit
struct StoresView: View {
    @State private var landmarks: [Landmark] = [Landmark]()
    @State var search = "Store"
    @ObservedObject var locationManager: LocationManager
    @Binding var landmark: Landmark
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    getNearbyLoc()
                }
            LocList(landmarks: landmarks, locationManager: locationManager, landmark: $landmark)
        }
    }
    private func getNearbyLoc() {
           
           let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = search
           
           let search = MKLocalSearch(request: request)
           search.start { (response, error) in
               
               if let response = response {
                   
                   let mapItems = response.mapItems
                   
                   self.landmarks = mapItems.map {
                       Landmark(placemark: $0.placemark)
                   }
               }
           }
}
}

