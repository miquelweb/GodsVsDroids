//
//  ViewController.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 4/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    var demon:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        infoView.isHidden = true
        
        let annotations = getMapAnnotations()
        // Add mappoints to Map
        addBoundry()
        mapView.addAnnotations(annotations)
        checkLocationAuthorizationStatus()
        let pos:CLLocation = CLLocation(latitude: 41.4172699, longitude: 2.2058407)
        centerMapOnLocation(location: pos)
        
    }
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showInfo(id:Int,name:String){
        //NSLog(String(id))
        infoView.isHidden = false
        nameLbl.text=name;
        demon = id
    }
    
        
    //MARK:- Annotations
    
    func getMapAnnotations() -> [PlayerPosition] {
    var annotations:Array = [PlayerPosition]()
    
    //load plist file
    var players: NSArray?
    if let path = Bundle.main.path(forResource: "PlayersPositions", ofType: "plist") {
    players = NSArray(contentsOfFile: path)
    }
        
      
    
    //iterate and create annotations
    if let items = players {
        for item in items {
            let lat = (item as AnyObject).value(forKey: "lat") as! Double
            let long = (item as AnyObject).value(forKey: "long") as! Double
            let no = (item as AnyObject).value(forKey: "no") as! Int
            let annotation = PlayerPosition(latitude: 41.4172699 + (Double(arc4random_uniform(20)) - 10) / 1000 , longitude: 2.2058407 + (Double(arc4random_uniform(20)) - 10) / 1000, no: no)
            annotation.title = (item as AnyObject).value(forKey: "title") as? String
            
            annotations.append(annotation)
        }
    }
    
    return annotations
    }
    
    func addBoundry()
    {
        var points=[CLLocationCoordinate2DMake(-85, 90),CLLocationCoordinate2DMake(-85,  -90),CLLocationCoordinate2DMake(85, -90),CLLocationCoordinate2DMake(85, 90)]
        
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        
        
        
        mapView.add(polygon)
        
    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    //MARK: Mapkit
    private let reuseIdentifier = "MyIdentifier"

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.image = UIImage(named: "eye.png")
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
          if view.annotation is MKUserLocation {
          }
          else{
        let annot = view.annotation as! PlayerPosition
            showInfo(id: annot.no, name:annot.title!);
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
            let polygonView = MKPolygonRenderer(overlay: overlay)
        polygonView.fillColor = UIColor.black
        polygonView.strokeColor = UIColor.black
        
            return polygonView
        
    }
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ShootingSegue" {
            let dest:ShootingViewController = segue.destination as! ShootingViewController
            dest.demon = demon
        }
        if segue.identifier == "SwordsSegue" {
            let dest:SwordsViewController = segue.destination as! SwordsViewController
            dest.demon = demon
        }
        
    }


}

