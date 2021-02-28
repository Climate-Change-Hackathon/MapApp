//
//  ReportView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift
struct ReportView: View {
   
    @Binding var report: Bool
    @ObservedObject var locationManager: LocationManager
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
    @Binding var reports: [Report]
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
        
                      LazyVGrid(columns: columns, spacing: 20) {
                        
                        Button(action: {
                            report(type: "Traffic")
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "speedometer")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Traffic")
                                    .foregroundColor(Color("LightGreen"))
                                    .font(.headline)
                            }
                        }
                        Button(action: {
                            report(type: "Police")
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "person")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Police")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        }
                        Button(action: {
                            report(type: "Eco-Friendly")
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "building")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Eco-Friendly")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        }
                        Button(action: {
                            report(type: "Hazard")
                        }) {
                            VStack {
                            ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(Color("ExtraLightGreen"))
                                Image(systemName: "stop")
                                    .foregroundColor(Color("Green"))
                        }
                                Text("Hazard")
                                    .font(.headline)
                                    .foregroundColor(Color("LightGreen"))
                            }
                        
                      }
            }
            VStack {
               
                HStack {
                  
                    Button(action: {
                        report = false
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
    func report(type: String) {
        let db = Firestore.firestore()
        
        do{
            let report = Report(id: locationManager.currentLocation.coordinate.longitude.removeZerosFromEnd(), type: type, date: Date(), location: GeoPoint(latitude: Double(locationManager.currentLocation.coordinate.latitude), longitude: Double(locationManager.currentLocation.coordinate.longitude)))
            try db.collection("reports").document(locationManager.currentRegion?.center.latitude.removeZerosFromEnd() ?? "").setData(from: report)
            reports.append(report)
            
        } catch {
            
        }
    }
    }

