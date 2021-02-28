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
    var id: String
    var date: [Date]
    
}
