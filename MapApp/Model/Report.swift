//
//  Report.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
struct Report: Identifiable, Codable, Equatable {
    var id: String
    var type: String
    var date: Date
    var location: GeoPoint
}

