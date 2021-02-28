//
//  HomeView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift
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
    @EnvironmentObject var userData: UserData
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                    
                    .onAppear() {
                        //SpeechService.shared.speak(text: "Hello") {
                            
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        region = locationManager.currentRegion ?? MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
                            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                            
                            self.loadNearby() { userData in
                                //Get completion handler data results from loadData function and set it as the recentPeople local variable
                                for data in userData {
                                    self.reports.append(data)
                                }
                                reports = reports.removeDuplicates()
                            }
                        }
                      
                        
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
    
    func loadNearby(performAction: @escaping ([Report]) -> Void) {
        let db = Firestore.firestore()
     let docRef = db.collection("reports")
        var userList:[Report] = []
        //Get every single document under collection users
        let lat = 0.0144927536231884
            let lon = 0.0181818181818182

        let lowerLat = locationManager.currentLocation.coordinate.latitude - (lat * 10)
            let lowerLon = locationManager.currentLocation.coordinate.longitude - (lon * 10)

            let greaterLat = locationManager.currentLocation.coordinate.latitude + (lat * 10)
            let greaterLon = locationManager.currentLocation.coordinate.longitude + (lon * 10)

            let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
            let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)
        let query = docRef.whereField("location", isLessThan: greaterGeopoint)
        query.getDocuments { (documents, error) in
           
        for document in documents!.documents {
                let result = Result {
                    try document.data(as: Report.self)
                }
                switch result {
                    case .success(let user):
                        if let user = user {
                            userList.append(user)
                 
                        } else {
                            
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding user: \(error)")
                    }
     
        
            }
              performAction(userList)
        }
    }
}

