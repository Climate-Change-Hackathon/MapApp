//
//  DirectionRow.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import MapKit
struct DirectionsRow: View {
    @State var step = MKRoute.Step()
    @State var distance = Measurement(value: 0.0, unit: UnitLength.miles)
    var body: some View {
        ZStack {
            Color(.clear)
                .onAppear() {
                    let feet = Measurement(value: step.distance, unit: UnitLength.feet)
                    distance = feet.converted(to: UnitLength.miles)
                }
        HStack {
            if step.instructions.lowercased().contains("left") {
            Image(systemName: "arrow.left")
                .font(.title)
            }
            if step.instructions.lowercased().contains("right") {
            Image(systemName: "arrow.right")
                .font(.title)
            }
            if step.instructions.lowercased().contains("straight") {
            Image(systemName: "arrow.up")
                .font(.title)
            }
            if step.instructions.lowercased().contains("exit") {
            Image(systemName: "xmark")
                .font(.title)
            }
            if step.instructions.lowercased().contains("roundabout") {
            Image(systemName: "arrow.counterclockwise")
                .font(.title)
            }
            Spacer()
            
            VStack {
                HStack {
                    Spacer()
                    Text("\(distance.value)")
                    .font(.title)
                        .foregroundColor(.black)
                    .bold()
                        .multilineTextAlignment(.trailing)
                    Text("\(distance.unit.symbol)")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Spacer()
                Text(step.instructions)
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                }
            }
            }
        } .padding()
        }
    }


