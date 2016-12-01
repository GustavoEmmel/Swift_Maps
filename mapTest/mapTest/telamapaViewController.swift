//
//  telamapaViewController.swift
//  mapTest
//
//  Created by Felipe Malta on 27/09/16.
//  Copyright © 2016 4tap. All rights reserved.
//

import UIKit
import MapKit

class telamapaViewController: UIViewController, MKMapViewDelegate {
    var coordenadas: [[Double]]!
    var nomes:[String]!
    var enderecos:[String]!
    var telefones:[String]!

    @IBOutlet var meuMapa: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        coordenadas = [[48.85672,2.35501],[48.85196,2.33944],[48.85376,2.33953]]// Latitude,Longitude
        nomes = ["Coffee Shop · Rue de Rivoli","Cafe · Boulevard Saint-Germain","Coffee Shop · Rue Saint-André des Arts"]
        enderecos = ["46 Rue de Rivoli, 75004 Paris, France","91 Boulevard Saint-Germain, 75006 Paris, France","62 Rue Saint-André des Arts, 75006 Paris, France"]
        telefones = ["+33 1 44 78 94 78","+33 1 46 34 52 68","+33 1 46 34 06 72"]
        self.meuMapa.delegate = self
        // 2
        for i in 0...2
        {
            let coordinate = coordenadas[i]
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: coordinate[0] , longitude: coordinate[1] )
            pin.title = nomes[i]
            pin.subtitle = enderecos[i]
            
            self.meuMapa.addAnnotation(pin)
        }
    
        // 3
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219000000177), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.meuMapa.setRegion(region, animated: true)
        
        // Do any additional setup after loading the view.
    }

    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {
            return nil
        }
        
        var annotationView = self.meuMapa.dequeueReusableAnnotationView(withIdentifier: "Pin") as?MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
           
        }else{
            annotationView?.annotation = annotation
        }
       
        annotationView?.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        annotationView?.pinTintColor = UIColor.purple
       
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView){
        guard !(view.annotation  is MKUserLocation) else{return}
    
        if let pinSelecionado = view.annotation as? MKPointAnnotation{
            
            print(pinSelecionado.title)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
    
        if let pinSelecionado = view.annotation as? MKPointAnnotation{
            
            print(pinSelecionado.title)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
