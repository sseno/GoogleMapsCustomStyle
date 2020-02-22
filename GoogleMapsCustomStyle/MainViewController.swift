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
import GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class MainViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var mapView = GMSMapView()
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    var chosenPlace: MyPlace?
    
    var startupPreviewView: StartupPreviewView = {
        let v = StartupPreviewView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    let previewDemoData = [(title: "Apple Academy", img: #imageLiteral(resourceName: "startup1")),
                           (title: "Bukalapak", img: #imageLiteral(resourceName: "startup2")),
                           (title: "Innovation Bandung", img: #imageLiteral(resourceName: "startup3"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -6.896616, longitude: 107.613125, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        mapView.settings.compassButton = true
        
        startupPreviewView = StartupPreviewView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 120, height: 250))
        startupPreviewView.layer.cornerRadius = 10
        
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
    
    func showPartyMarkers(lat: Double, long: Double) {
        mapView.clear()
        for i in 0..<3 {
            let randNum=Double(arc4random_uniform(30))/10000
            let marker=GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.darkGray, tag: i)
            marker.iconView = customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
            }
            marker.map = self.mapView
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
    
    @objc func startupTapped(tag: Int) {
        let vc = DetailStartupVC()
        vc.passedData = previewDemoData[tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
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
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        
//        guard let location = locations.first else {
//          return
//        }
//        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        guard let location = locations.last else { return }
        let lat = (location.coordinate.latitude)
        let long = (location.coordinate.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 17.0)
        
        self.mapView.animate(to: camera)
        
        showPartyMarkers(lat: lat, long: long)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting location \(error)")
    }
}

// MARK: - GMSMapViewDelegate
extension MainViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        
        marker.iconView = customMarker
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return nil }
        let data = previewDemoData[customMarkerView.tag]
        startupPreviewView.setData(title: data.title, img: data.img)
        
        return startupPreviewView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let tag = customMarkerView.tag
        startupTapped(tag: tag)
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.darkGray, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
}
