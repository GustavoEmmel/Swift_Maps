//
//  telamapaCustomViewController.swift
//  mapTest
//
//  Created by Felipe Malta on 30/09/16.
//  Copyright © 2016 4tap. All rights reserved.
//

import UIKit
import MapKit

class telamapaCustomViewController:  UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var coordenadas: [[Double]]!
    var nomes:[String]!
    var enderecos:[String]!
    var telefones:[String]!
    var pinDetail = CustomPin()
    
    
    @IBOutlet weak var tableDetail: UITableView!
    
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
                    let pin = CustomPin(coordinate: CLLocationCoordinate2D(latitude: coordinate[0] , longitude: coordinate[1] ))
                    pin.nome = nomes[i]
                    pin.title = nomes[i]
                    pin.endereco = enderecos[i]
                    pin.telefone = telefones[i]
                    self.meuMapa.addAnnotation(pin)
                }
    
        // 3
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219000000177), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.meuMapa.setRegion(region, animated: true)
        
        self.tableDetail.delegate = self
        self.tableDetail.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {
            return nil
        }
        
        var annotationView = self.meuMapa.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            
        }else{
            annotationView?.annotation = annotation
        }
        //annotationView?.tintColor = UIColor.yellow
        annotationView?.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
        annotationView?.image = UIImage(named: "starbucks")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView){
        guard !(view.annotation  is MKUserLocation) else{return}
        
        if let pinSelecionado = view.annotation as? CustomPin{
            
            //print(pinSelecionado.nome)
            pinDetail = pinSelecionado
            print(pinDetail.nome)
            print(pinDetail.endereco)
            
            tableDetail.reloadData()
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        if let pinSelecionado = view.annotation as? CustomPin{
            
            //print(pinSelecionado.nome)
            
            pinDetail = pinSelecionado
            print(pinDetail.nome)
            print(pinDetail.endereco)
            
            tableDetail.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellteste", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = pinDetail.nome
        case 1:
            cell.textLabel?.text = pinDetail.title
        case 2:
            cell.textLabel?.text = pinDetail.endereco
        case 3:
            cell.textLabel?.text = pinDetail.telefone
        default:
            break
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.pinDetail.nome
    }
}














