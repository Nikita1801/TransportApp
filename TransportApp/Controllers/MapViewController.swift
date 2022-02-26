//
//  MapViewController.swift
//  TransportApp
//
//  Created by Никита Макаревич on 24.02.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var id : String?

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id!)
        
    }
    

   

}
