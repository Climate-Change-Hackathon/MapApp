//
//  HeaderView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI

struct HeaderView: View {
    @State var isSearching = false
    @State var search = ""
    @ObservedObject var locationManager = LocationManager()
    var body: some View {
        
        HStack {
            if !isSearching {
            Button(action: {
                
            }) {
                ZStack {
                    
                    Circle()
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("Light"))
                        .opacity(0.8)
                    Image(systemName: "sidebar.left")
                        .foregroundColor(Color("Green"))
                        .font(.headline)
                }
            }   .padding()
            Spacer()
            }
            Button(action: {
                withAnimation(.easeInOut) {
                    isSearching.toggle()
                    if !isSearching {
                        locationManager.buildRoute()
                    }
                }
            }) {
                ZStack {
                    
                    Circle()
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("Light"))
                        .opacity(0.8)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Green"))
                        .font(.headline)
                        .padding()
                }
            }
            if isSearching {
                ZStack {
                    
                    TextField("Search", text: $search)
                        
                        .padding()
                        .background( RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundColor(Color("Light")).opacity(0.8))
                    
                }  .padding()
                .onChange(of: search, perform: { value in
                    locationManager.search = search
                })
                .sheet(isPresented: $locationManager.show, content: {
                    EmptyView()
                })
            } else {
                Button(action: {
                    
                }) {
                    ZStack {
                        
                        Circle()
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color("Light"))
                            .opacity(0.8)
                        Image(systemName: "gear")
                            .foregroundColor(Color("Green"))
                            .font(.headline)
                            .padding()
                    }
                }
             
            }
        }
    }
}


