//
//  LocListCell.swift
//  MapApp
//
//  Created by Fahim Rahman on 27/2/21.
//
import SwiftUI
import MapKit

struct LocList: View {
    @Binding var region: MKCoordinateRegion
    @Binding var route: Route
    @Binding var mkRoute: MKRoute
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            LazyVStack {
                
                ForEach(0..<10) {_ in LocListCell(region: $region, route: $route, mkRoute: $mkRoute) }
                    .listRowBackground(Color("Light"))
                    .opacity(0.8)
            }
        }
        .background(Color("Light"))
        .opacity(0.8)
        .edgesIgnoringSafeArea([.bottom])
    }
    
}


struct LocListCell: View {
@State var open = false
    @Binding var region: MKCoordinateRegion
    @Binding var route: Route
    @Binding var mkRoute: MKRoute
    var body: some View {

        Button(action: {
            open = true
        }) {
            
        
        ZStack {

            Rectangle()
                .fill(Color(red: 50/255, green: 50/255, blue: 50/255))
                .frame(width: 260, height: 80, alignment: .center)
                .cornerRadius(20)
                .padding([.leading, .trailing], 5)


            HStack {

                ZStack {

                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 131/255, green: 212/255, blue: 117/255), Color(red: 46/255, green: 182/255, blue: 44/255)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 60, height: 60, alignment: .center)


                    VStack {

                        Text("1.4")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .bold, design: .rounded))


                        Text("km")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.black)

                    }
                }
                .padding(.trailing)


                VStack {

                    Text("Tattoine")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding([.top], 5)
                        .padding(.trailing)


                    HStack {

                        Image(systemName: "mappin")
                            .foregroundColor(.white)

                        Text("Lat: 23.88")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.green)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .padding(.bottom, 5)
                    }


                    HStack {

                        Image(systemName: "mappin")
                            .foregroundColor(.white)

                        Text("Lon: 90.45")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.green)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .padding(.bottom, 5)
                    }
                }
                .padding(.leading)
            }
        }
       
        } .sheet(isPresented: $open, content: {
            ArrivalInputView(mkRoute: $mkRoute, region: $region)
        })
    } 
}

