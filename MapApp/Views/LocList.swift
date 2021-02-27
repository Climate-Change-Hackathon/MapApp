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
    
    var body: some View {
            
            List {
                
                ForEach(self.landmarks, id: \.id) { landmark in LocListCell(
                    
                    name: landmark.name,
                    lat: landmark.lat,
                    lon: landmark.lon
                )
                }
                    .listRowBackground(Color("Light"))
                    .opacity(0.8)
            }
            
        .background(Color("Light"))
        .opacity(0.8)
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
    
    @State var name: String
    @State var lat: Double
    @State var lon: Double
    
    var body: some View {

        ZStack {

            HStack {

                ZStack {

                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 131/255, green: 212/255, blue: 117/255), Color(red: 46/255, green: 182/255, blue: 44/255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 60, height: 60, alignment: .center)


                    VStack {

                        Text("1.4")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold, design: .rounded))


                        Text("Mi")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)

                    }
                }
                .padding(.trailing)


                VStack(alignment: .leading) {

                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding([.top], 5)
                        .padding(.trailing)


                    HStack {

                        Image(systemName: "mappin")
                            .foregroundColor(.white)

                        Text("Lat: \(lat.rounded())")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.green)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .padding(.bottom, 5)
                    }


                    HStack {

                        Image(systemName: "mappin")
                            .foregroundColor(.white)

                        Text("Lon: \(lon.rounded())")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.green)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .padding(.bottom, 5)
                    }
                }
                .padding(.leading)
            }
        }
    }
}
