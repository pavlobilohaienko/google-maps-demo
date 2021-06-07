//
//  CLLocationCoordinate2D+Equatable.swift
//  google-maps-demo
//
//  Created by Pavlo Bilohaienko on 10.01.2020.
//  Copyright © 2020 Pavlo Bilohaienko. All rights reserved.
//

import Foundation
import CoreLocation


extension CLLocationCoordinate2D: Equatable {
	
	public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		
		return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
	}
}
