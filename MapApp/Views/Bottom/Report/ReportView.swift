//
//  ReportView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit

struct ReportView: View {
   
    @Binding var report: Bool
    
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
        ]
  
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
        
                      LazyVGrid(columns: columns, spacing: 20) {
                        
                        Button(action: {
                            
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
}
