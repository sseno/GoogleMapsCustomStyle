//
//  MainViewController.swift
//  GoogleMapsCustomStyle
//
//  Created by Rohmat Suseno on 20/01/20.
//  Copyright © 2020 Rohmts. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MainViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -6.896616, longitude: 107.613125, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        
        updateMapTheme()
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -6.896616, longitude: 107.613125)
        marker.title = "Eduplex Group"
        marker.snippet = "lorem ipsum"
        marker.map = mapView
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard #available(iOS 13.0, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
        else { return }
        
        updateMapTheme()
    }
    
    private func updateMapTheme() {        
        switch traitCollection.userInterfaceStyle {
        case .light:
            view = switchMapStyle(toNight: false)
        case .dark:
            view = switchMapStyle(toNight: true)
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    
    private func switchMapStyle(toNight: Bool) -> GMSMapView {
        do {
          // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: toNight ? "MapNight" : "MapLight", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        return mapView
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
          return
        }
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
          return
        }
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
          
        locationManager.stopUpdatingLocation()
    }
}
