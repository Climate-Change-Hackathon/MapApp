//
//  MapView.swift
//  MapApp
//
//  Created by Andreas on 2/26/21.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapExample: View {
    @State private var cities: [City] = [
        City(coordinate: .init(latitude: 40.7128, longitude: 74.0060)),
        City(coordinate: .init(latitude: 37.7749, longitude: 122.4194)),
        City(coordinate: .init(latitude: 47.6062, longitude: 122.3321))
    ]

    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: cities) { city in
            MapAnnotation(
                coordinate: city.coordinate,
                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            ) {
                Circle()
                    .stroke(Color.green)
                    .frame(width: 44, height: 44)
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var route: MKRoute
    @Binding var reports: [Report]
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
           
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .green
            renderer.lineWidth = 4
            
            return renderer
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        for report in reports {
            if report.date.addingTimeInterval(60 * 60) > Date() {
        let london = MKPointAnnotation()
            london.title = report.type
            london.coordinate = CLLocationCoordinate2D(latitude: report.location.latitude, longitude: report.location.longitude)
        mapView.addAnnotation(london)
            }
        }
        if route.name != "" {
        mapView.addOverlay(route.polyline)
        }
        mapView.delegate = context.coordinator
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
