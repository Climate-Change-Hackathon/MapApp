//
//  LocationManager.swift
//  MapApp
//
//  Created by Andreas on 2/27/21.
//

import Foundation
import CoreLocation
import Combine
import MapKit
class LocationManager: NSObject, ObservableObject {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var currentRegion: MKCoordinateRegion?
    @Published var currentPlace: CLPlacemark?
    @Published var completer = MKLocalSearchCompleter()
    @Published var search = ""
    @Published var show = false
    @Published var route = Route(origin: MKMapItem(), stops: [MKMapItem]())
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
    
    
    func buildRoute() {
    let segment: RouteBuilder.Segment?
    if let currentLocation = currentPlace?.location {
      segment = .location(currentLocation)
    }  else {
      segment = nil
    }

    let stopSegments: [RouteBuilder.Segment] = [
        search
    ]
    .compactMap { contents in
       let value = contents
        return .text(value)
      }
    

    guard
      let originSegment = segment,
      !stopSegments.isEmpty
      else {
        print("none")
        return
    }

    RouteBuilder.buildRoute(
      origin: originSegment,
      stops: stopSegments,
      within: currentRegion
    ) { result in
     

      switch result {
      case .success(let route):
        
        self.route = route
        self.show = true
print(route)
      case .failure(let error):
        let errorMessage: String

        switch error {
        case .invalidSegment(let reason):
          errorMessage = "There was an error with: \(reason)."
            print(errorMessage)
        }

       
      }
    }
    }
}

extension LocationManager: CLLocationManagerDelegate {

  
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
          return
        }

        manager.requestLocation()
      }

      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {
          return
        }

        let commonDelta: CLLocationDegrees = 25 / 111 // 1/111 = 1 latitude km
        let span = MKCoordinateSpan(latitudeDelta: commonDelta, longitudeDelta: commonDelta)
        let region = MKCoordinateRegion(center: firstLocation.coordinate, span: span)

        currentRegion = region
        completer.region = region

        CLGeocoder().reverseGeocodeLocation(firstLocation) { places, _ in
            guard let firstPlace = places?.first, self.search == "" else {
                print("")
            return
          }

          self.currentPlace = firstPlace
            self.search = firstPlace.abbreviation
        }
      }

      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
      }
    }


