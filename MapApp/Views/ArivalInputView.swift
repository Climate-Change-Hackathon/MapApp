//
//  ArivalInputView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift
struct ArrivalInputView: View {
    @State var arrivalDate = Date()
    @Binding var mkRoute: MKRoute
    @Binding var region: MKCoordinateRegion
    @State var reports = [Report]()
    @ObservedObject var locationManager: LocationManager
    @Binding var schedule: Bool
    @State var conflict = false
    @EnvironmentObject var userData: UserData
    var body: some View {
        ZStack {
        VStack {
            MapView(region: $region, route: $mkRoute, reports: $reports)
                .onAppear() {
                   
                }
            HStack {
            Text("Leave Date")
                .font(.title)
                .bold()
                Spacer()
            } .padding()
        DatePicker("Please enter a date", selection: $arrivalDate)
               .labelsHidden()
            //.datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            Spacer()
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                plan()
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(height: 60)
                        .padding()
                        .foregroundColor(Color("ExtraLightGreen"))
                    Text("Enter")
                        .font(.headline)
                        .foregroundColor(Color("Green"))
                }
            }
        }
            if conflict {
                
                Color(.systemBackground)
                    
                Text("Please select another date to reduce traffic")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack {
                    HStack {
                        Button(action: {
                            conflict = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding()
                                .foregroundColor(Color("Green"))
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
    }
    }
    func plan() {
      
        let db = Firestore.firestore()
        let docRef = db.collection("plannedCommutes").document(locationManager.currentPlace?.locality ?? "error" + (locationManager.currentPlace?.administrativeArea ?? ""))
        var plannedCommute = PlannedCommute(id: locationManager.currentPlace?.locality ?? "" + (locationManager.currentPlace?.administrativeArea ?? "") , date: [])
        docRef.getDocument { (document, error) in
            
            let result = Result {
                try document?.data(as: PlannedCommute.self)
            }
            switch result {
                case .success(let user):
                    if let user = user {
                        plannedCommute.date =  user.date
                        for date in user.date {
                            if date.addingTimeInterval(5) > arrivalDate {
                                if date.addingTimeInterval(-5)  < arrivalDate {
                                    conflict = true
                                }
                            }
                        }
                        if !conflict {
                                do {
                                    plannedCommute.date.append(arrivalDate)
                                        
                                   
                                    try db.collection("plannedCommutes").document(plannedCommute.id).setData(from: plannedCommute)
                                    schedule = false
                                    conflict = false
                                    userData.carboncoins += 5
                                } catch {
                                    
                                }
                                }
                        
                    } else {
                        do {
                            plannedCommute.date.append(arrivalDate)
                                
                           
                            try db.collection("plannedCommutes").document(plannedCommute.id).setData(from: plannedCommute)
                            schedule = false
                            conflict = false
                            userData.carboncoins += 5
                        } catch {
                            
                        }
                        print("Document does not exist")
                        
                    }
                case .failure(let error):
                    print("Error decoding user: \(error)")
                }
        }
           
            
                
            
            
        
        
    }
}

