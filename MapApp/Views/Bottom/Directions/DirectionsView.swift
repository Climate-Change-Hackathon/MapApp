//
//  DirectionsView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct DirectionsView: View {
    @Binding var route: Route

    @State var mapRoutes: [MKRoute] = []
    @State var totalTravelTime: TimeInterval = 0
    @State var totalDistance: CLLocationDistance = 0

    @State var groupedRoutes: [(startItem: MKMapItem, endItem: MKMapItem)] = []
    
    @Binding var mkRoute: MKRoute
    @Binding var directions: Bool
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    groupAndRequestDirections()
                }
            List {
        ForEach(mapRoutes.first?.steps ?? [], id: \.self) { step in
            DirectionsRow(step: step)
        }
            }
            if ((mapRoutes.first?.steps.isEmpty) != nil) {
                Text("Pick a route to display directions")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
            }
            VStack {
               
                HStack {
                  
                    Button(action: {
                        directions = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .padding()
                            .foregroundColor(Color("Green"))
                    }
                    Spacer()
                }
                Spacer()
            } .padding()
        }
    }
    
    private func groupAndRequestDirections() {
      guard let firstStop = route.stops.first else {
        return
      }

      groupedRoutes.append((route.origin, firstStop))

      if route.stops.count == 2 {
        let secondStop = route.stops[1]

        groupedRoutes.append((firstStop, secondStop))
        groupedRoutes.append((secondStop, route.origin))
      }

      fetchNextRoute()
    }

    private func fetchNextRoute() {
      guard !groupedRoutes.isEmpty else {
       
        return
      }

      let nextGroup = groupedRoutes.removeFirst()
      let request = MKDirections.Request()

      request.source = nextGroup.startItem
      request.destination = nextGroup.endItem

      let directions = MKDirections(request: request)

      directions.calculate { response, error in
        guard let mapRoute = response?.routes.first else {
          
          return
        }
        mkRoute = mapRoute
        mapRoutes.append(mapRoute)

       
        self.fetchNextRoute()
      }
    }
}

