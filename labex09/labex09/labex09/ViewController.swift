//
//  ViewController.swift
//  labex09
//
//  Created by Elizabeth Thomas on 2025-03-20.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let torontoCoordinates = CLLocationCoordinate2D(latitude: 43.65, longitude: -79.34)
        
        let regionSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: torontoCoordinates, span: regionSpan)
       
        mapView.setRegion(region, animated: true)
        
        mapView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_ :)))
        
        mapView.addGestureRecognizer(tapGesture)
        
    }
        
        
        
    @objc func mapTapped(_ sender: UITapGestureRecognizer) {
      let location = sender.location(in: mapView)
      let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        for annotation in mapView.annotations {
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let tappedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            if tappedLocation.distance(from: annotationLocation) < 10 {
                mapView.removeAnnotation(annotation)
                print("Annotation removed")
                return
            }
        }
        
        if mapView.annotations.count < 3 {
            addAnnotation(coordinate: coordinate)
        } else {
            print("You can only add up to 3 locations")
        }
        
        if mapView.annotations.count == 3 {
            drawTriangle()
        }
     }
    
    @IBAction func routeButtonTapped(_ sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        print("map cleared")
        

    }
    
    
    func drawTriangle() {
        guard mapView.annotations.count == 3 else { return }
        
        let coordinates = mapView.annotations.map { $0.coordinate }
        
        let triangle = MKPolygon(coordinates: coordinates, count: coordinates.count)
        
        mapView.addOverlay(triangle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 2.0
            renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    func calculateDistance(from location1: CLLocation, to location2: CLLocation) -> Double {
        let distance = location1.distance(from: location2)
        return distance
    }
    
    func addAnnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Location \(mapView.annotations.count + 1)"
        mapView.addAnnotation(annotation)
    }
    
    func calculateDistances(){
        if mapView.annotations.count == 3 {
            let location1 = CLLocation(latitude: mapView.annotations[0].coordinate.latitude, longitude: mapView.annotations[0].coordinate.longitude)
            
            let location2 = CLLocation(latitude: mapView.annotations[1].coordinate.latitude, longitude: mapView.annotations[1].coordinate.longitude)
            
            let location3 = CLLocation(latitude: mapView.annotations[2].coordinate.latitude, longitude: mapView.annotations[2].coordinate.longitude)
            
            let distance1 = calculateDistance(from: location1, to: location2)
            let distance2 = calculateDistance(from: location2, to: location3)
            let distance3 = calculateDistance(from: location3, to: location1)
            
            print("Distance1: \(distance1) meters")
            print("Distance2: \(distance2) meters")
            print("Distance3: \(distance3) meters")
        }
    }

}
