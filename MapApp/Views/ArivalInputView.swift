//
//  ArivalInputView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit
struct ArrivalInputView: View {
    @State var arrivalDate = Date()
    @Binding var mkRoute: MKRoute
    @Binding var region: MKCoordinateRegion
    var body: some View {
        VStack {
            MapView(region: $region, route: $mkRoute)
            HStack {
            Text("Arrival Date")
                .font(.title)
                .bold()
                Spacer()
            } .padding()
        DatePicker("Please enter a date", selection: $arrivalDate)
               .labelsHidden()
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
    }
    }
}

