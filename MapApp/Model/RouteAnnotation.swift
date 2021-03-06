//
//  RouteAnnotation.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import MapKit

class RouteAnnotation: NSObject {
  private let item: MKMapItem

  init(item: MKMapItem) {
    self.item = item

    super.init()
  }
}

// MARK: - MKAnnotation

extension RouteAnnotation: MKAnnotation {
  var coordinate: CLLocationCoordinate2D {
    return item.placemark.coordinate
  }

  var title: String? {
    return item.name
  }
}
