//
//  MapViewController.swift
//  TransportApp
//
//  Created by Никита Макаревич on 24.02.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var id : String?
    var lat : Double?
    var lon : Double?
    var name : String?
    

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //print("!!!!!!!!!!!!\(id)!!!!!!!!")
        mapThis(lat: lat, lon: lon)
        
        
    }
    
    
    //MARK: Map
    func mapThis(lat : Double?, lon : Double?) {
       
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        annotation.title = name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "StopImage")
    
        return annotationView
    }
    
    // Perform BottomSheet
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let bottomSheetVC = self.storyboard?.instantiateViewController(withIdentifier: "BottomSheetController") as! BottomSheetController//BottomSheetController()
        bottomSheetVC.mapVC = self
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.presentingViewController.title = "Details"
            sheet.preferredCornerRadius = 20
        }
        present(bottomSheetVC, animated: true)
    }

   

}
