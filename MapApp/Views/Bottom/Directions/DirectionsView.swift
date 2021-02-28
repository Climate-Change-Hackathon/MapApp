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

    @Binding var mapRoutes: [MKRoute] 
    @State var totalTravelTime: TimeInterval = 0
    @State var totalDistance: CLLocationDistance = 0

    @State var groupedRoutes: [(startItem: MKMapItem, endItem: MKMapItem)] = []
    
    @Binding var mkRoute: MKRoute
    @Binding var directions: Bool
    @State var alreadySaid = [Bool]()
    @State var ready = false
    @EnvironmentObject var userData: UserData
    var body: some View {
        ZStack {
            Color("Light")
                .onAppear() {
                    
                    if mapRoutes.isEmpty {
                    groupAndRequestDirections()
                    }
                   
                        let route = mapRoutes.last ?? MKRoute()
                        for i in route.steps.indices  {
                            alreadySaid.append(false)
                    
                    }
                    let timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
                        let route = mapRoutes.last ?? MKRoute()
                        for i in route.steps.indices {
                           
                            if mapRoutes.last?.steps[i].distance ?? 0.0 < 5 {
                                let isIndexValid = alreadySaid.indices.contains(i)
                                if isIndexValid {
                                if !alreadySaid[i] {
                            SpeechService.shared.speak(text: mapRoutes.last?.steps[i].instructions ?? "") {
                                alreadySaid[i] = true
                            }
                            }
                                } else {
                                    alreadySaid.append(false)
                                }
                            }
                        
                    }
                    }
                    print(mapRoutes.last?.steps)
                }
            if ((mapRoutes.last?.steps.isEmpty) != nil) {
                Color(.secondarySystemBackground)
                Text("Pick a route to display directions")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
               
            }
           
                if ((mapRoutes.last?.steps.isEmpty) != nil) {
            List {
        ForEach(mapRoutes.last!.steps, id: \.self) { step in
            DirectionsRow(step: step)
        }
            } .padding(.top, 62)
            
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
    
     func groupAndRequestDirections() {
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
        ready = true

    }

     func fetchNextRoute() {
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
        let miles = mkRoute.distance * 0.000621371
        userData.trees = miles * 8887 / 59.81068991
       
        self.fetchNextRoute()
      }
    }
}

