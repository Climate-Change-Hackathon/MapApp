//
//  LocListCell.swift
//  MapApp
//
//  Created by Fahim Rahman on 27/2/21.
//
import SwiftUI
import MapKit


// MARK: - Location List View
struct LocList: View {
    
    let landmarks: [Landmark]
    @ObservedObject var locationManager: LocationManager
    @Binding var landmark: Landmark
    @Binding var directions: Bool
    var body: some View {
            
            List {
              
                
                ForEach(self.landmarks, id: \.id) { landmark in LocListCell(
                    
                    landmarkLocal: landmark, name: landmark.name,
                    lat: landmark.lat,
                    lon: landmark.lon, locationManager: locationManager, landmark: $landmark, directions: $directions
                )
                }
                    .listRowBackground(Color("Light"))
                    .opacity(0.8)
            }
            
        .background(Color("Light"))
        
        .edgesIgnoringSafeArea([.bottom])
    }
}





// MARK: - Landmark Model
struct Landmark {

    let placemark: MKPlacemark

    var id: UUID {
        return UUID()
    }
    var name: String {
       
        return self.placemark.name ?? ""
    }
    
    var lat: Double {
        return self.placemark.coordinate.latitude
    }
    
    var lon: Double {
        return self.placemark.coordinate.longitude
    }
}






// MARK: - Location List Cell
struct LocListCell: View {
    @State var landmarkLocal: Landmark
    @State var name: String
    @State var lat: Double
    @State var lon: Double
    @ObservedObject var locationManager: LocationManager
    @State var distanceInMiles = 0.0
    @Binding var landmark: Landmark
    @Binding var directions: Bool
    var body: some View {
        Button(action: {
            locationManager.stopLocation = CLLocation(latitude: lat, longitude: lon)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            locationManager.buildRoute()
                if !locationManager.route.stops.isEmpty {
                directions = true
                }
            }
        }) {
            
        ZStack {
            Color(.clear)
                .onAppear() {
                    let distanceInMeters = locationManager.currentLocation.distance(from: CLLocation(latitude: lat, longitude: lon))
                    distanceInMiles = distanceInMeters*0.000621
                }
            HStack {

                ZStack {

                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 131/255, green: 212/255, blue: 117/255), Color(red: 46/255, green: 182/255, blue: 44/255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 60, height: 60, alignment: .center)


                    VStack {

                        Text(distanceInMiles.rounded(toPlaces: 1).removeZerosFromEnd())
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .font(.subheadline)


                        Text("Mi")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .font(.subheadline)
     
                    }
                }
               
Spacer()

                VStack(alignment: .leading) {

                    Text(name)
                        .foregroundColor(Color("Green"))
                        .font(.headline)
                        .multilineTextAlignment(.trailing)


                   
                }
             
            }
        }
        }
    }
}
