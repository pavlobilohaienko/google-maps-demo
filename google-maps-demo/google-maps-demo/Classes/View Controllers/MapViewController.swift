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
import RxSwift


final class MapViewController: UIViewController {
	
	// MARK: - Private properties
	
	private let defaultMapZoom: Float = 10
	private let bag = DisposeBag()
	private var userLocation = CLLocation(latitude: 0, longitude: 0) {
		didSet {
			if isTrackingCurrentLocation && userLocation.coordinate != oldValue.coordinate {
				guard let map = view as? GMSMapView else { return }
				userMarker.position = userLocation.coordinate
				map.animate(to: camera)
			}
		}
	}
	private lazy var userMarker: GMSMarker = {
		return GMSMarker(position: userLocation.coordinate)
	}()
	private var camera: GMSCameraPosition {
		let lattitude = userLocation.coordinate.latitude
		let longitude = userLocation.coordinate.longitude
		return GMSCameraPosition.camera(withLatitude: lattitude, longitude: longitude, zoom: defaultMapZoom)
	}
	private var isTrackingCurrentLocation = true
	
	
	// MARK: - Lifecycle
	
	override func loadView() {
		
		let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
		mapView.delegate = self
		userMarker.map = mapView
		view = mapView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		subscribe()
	}
}


// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
	
}


// MARK: - Private methods

private extension MapViewController {
	
	func subscribe() {
		
		LocationProvider.shared.lastLocationSubject.subscribe(onNext: { [weak self] location in
			if let lastLocation = location {
				self?.userLocation = lastLocation
			}
		}).disposed(by: bag)
	}
}
