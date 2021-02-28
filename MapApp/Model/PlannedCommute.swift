//
//  PlannedCommute.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
struct PlannedCommute: Identifiable, Codable, Equatable {
    var id: UUID
    var location: GeoPoint
    var date: Date
    
}
