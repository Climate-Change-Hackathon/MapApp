//
//  ArivalInputView.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI

struct ArrivalInputView: View {
    @State var arrivalDate = Date()
    var body: some View {
        VStack {
            Text("Arrival Date")
        DatePicker("Please enter a date", selection: $arrivalDate)
               .labelsHidden()
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
    }
    }
}

