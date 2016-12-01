//
//  CustomPin.swift
//  mapTest
//
//  Created by Felipe Malta on 30/09/16.
//  Copyright © 2016 4tap. All rights reserved.
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var subtitle: String? = ""
    var telefone: String! = ""
    var nome: String? = ""
    var endereco: String! = ""
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init()
        self.coordinate = coordinate
    }
}
