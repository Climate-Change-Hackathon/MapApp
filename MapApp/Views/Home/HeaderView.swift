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
    @State private var landmarks: [Landmark] = [Landmark]()
    @State var speed = 0.0
    @Binding var landmark: Landmark
    @State var schedule = false
    @EnvironmentObject var userData: UserData
    @Binding var directions: Bool
    var body: some View {
        ZStack {
        HStack {
            if !isSearching {
                ZStack {
                    Circle()
                        .foregroundColor(Color("ExtraLightGreen"))
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(speed.removeZerosFromEnd())
                       
                } .padding()
//            Button(action: {
//
//            }) {
//                ZStack {
//                    
//                    Circle()
//                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .foregroundColor(Color("ExtraLightGreen"))
//                        .opacity(0.8)
//                    Image(systemName: "sidebar.left")
//                        .foregroundColor(Color("Green"))
//                        .font(.headline)
//                }
//            }   .padding()
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
                        directions = true
                        typing = false
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
                   
                }  .padding()
                .onChange(of: search, perform: { value in
                    locationManager.search = search
                                   
                                   typing = true
                                   if search == "" { typing.toggle() }
                    DispatchQueue.main.async {
                                           self.getNearbyLoc()
                                       }
                    
                               })
                
                .onChange(of: locationManager.route.label, perform: { value in
                     route = locationManager.route
                })
               
                .onChange(of: locationManager.show, perform: { value in
                     show = locationManager.show
                })
                .onAppear() {
                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        speed = Double(locationManager.speed).rounded(toPlaces: 0)
                    }
                }
            } else {
               
                Button(action: {
                    schedule = true
                }) {
                    ZStack {

                        Circle()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(Color("ExtraLightGreen"))
                            .opacity(0.8)
                        Image(systemName: "clock")
                            .foregroundColor(Color("Green"))
                            .font(.headline)
                            .padding()
                    }
                }
             
            }
        }
        .sheet(isPresented: $schedule, content: {
            ArrivalInputView(mkRoute: $mkRoute, region: $region, locationManager: locationManager, schedule: $schedule)
        })
    }
        if typing {
            VStack {
                HStack {
                    Spacer()
                    LocList(landmarks: landmarks, locationManager: locationManager, landmark: $landmark, directions: $directions)
                .frame(width: 225, height: 300)
                .cornerRadius(25)
              
                }
                Spacer()
            } .padding()
        }
    
        
    }
    private func getNearbyLoc() {
           
           let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = search
        request.region = locationManager.currentRegion ?? MKCoordinateRegion(MKMapRect(x: 0, y: 0, width: 0, height: 0))
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


