//
//  LocationProvider.swift
//  google-maps-demo
//
//  Created by Pavlo Bilohaienko on 10.01.2020.
//  Copyright © 2020 Pavlo Bilohaienko. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift


final class LocationProvider: NSObject {
	
	// MARK: - Shared instance
	
	static let shared = LocationProvider()
	
	
	// MARK: - Private properties
	
	private let locationManager = CLLocationManager()
	
	
	// MARK: - Behaviour subjects

	var authorizationStatusSubject = BehaviorSubject<CLAuthorizationStatus?>(value: nil)
	var lastLocationSubject = BehaviorSubject<CLLocation?>(value: nil)
	
	
	// MARK: - Lifecycle
	
	private override init() {
		super.init()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	
	deinit {
		locationManager.stopUpdatingLocation()
	}
}


//  MARK: - CLLocationManagerDelegate

extension LocationProvider: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
		authorizationStatusSubject.onNext(status)
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		guard let location = locations.last else { return }
		lastLocationSubject.onNext(location)
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		
		print(#function, error)
	}
}
