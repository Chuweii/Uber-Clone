//
//  MapViewController.swift
//  Uber Clone
//
//  Created by Wei Chu on 2022/10/19.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView = MKMapView()
    let panel = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        title = "Uber"
        view.addSubview(mapView)
        
        
        setPanel()

    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    
    private func setPanel(){
        let searchVC = SearchViewController()
        searchVC.delegate = self
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
    }

}

//SearchViewDelegate 傳遞位置資訊
extension MapViewController:SearchViewControllerDelegate{
    func searchViewController(vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        
        guard let coordinates = coordinates else{
            return
        }
        
        //完成搜索後自動將panel縮至螢幕最下方
        panel.move(to: .tip, animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        
        //設定mapview上的定位距離比例
        mapView.setRegion(MKCoordinateRegion(center: coordinates, latitudinalMeters: 0.7, longitudinalMeters: 0.7), animated: true)
        
    }
}
