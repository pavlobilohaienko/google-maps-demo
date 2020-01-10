//
//  MapViewController.swift
//  google-maps-demo
//
//  Created by Pavlo Bilohaienko on 10.01.2020.
//  Copyright © 2020 Pavlo Bilohaienko. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps


final class MapViewController: UIViewController {
	
	// MARK: - Private properties
	
	private var userLocation = CLLocation(latitude: 0, longitude: 0) {
		didSet {
			if isTrackingCurrentLocation {
				guard let map = view as? GMSMapView else { return }
				map.animate(to: camera)
			}
		}
	}
	private var userMarker: GMSMarker {
		return GMSMarker(position: userLocation.coordinate)
	}
	private var camera: GMSCameraPosition {
		let lattitude = userLocation.coordinate.latitude
		let longitude = userLocation.coordinate.longitude
		return GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: 1.0)
	}
	private var isTrackingCurrentLocation = true
	
	
	// MARK: - Lifecycle
	
	override func loadView() {
		
		let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
		mapView.delegate = self
		userMarker.map = mapView
		view = mapView
	}
}


// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
	
}
