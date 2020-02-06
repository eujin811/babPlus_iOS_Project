//
//  BranchsAddressMapViewController.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit
import MapKit

class BranchsAddressMapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let mapCenter = CLLocationCoordinate2DMake(mapCenterlat, mapCenterlon)
    
    private var contents:BabMenu?
    
    private var pinNameList = [String]()
    private var pinAddressList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
//        setRgion()
        requestData()
        print("addressList: ",pinAddressList)
        
        setupUI()
    }
    
    private func requestData() {
        let APPDELEGATE = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
//        let contents = APPDELEGATE.dummy!.self
        contents = APPDELEGATE.dummy!.self 
        contents!.contents.keys.forEach {
            pinNameList.append($0)
            pinAddressList.append((contents!.contents[$0]!.address))
        }
        print("keys: ",pinNameList)
        

    }
    
    private func setRgion() {
        let coordinate = CLLocationCoordinate2DMake(mapCenterlat, mapCenterlon)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func setupUI() {
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        setRgion()
//        setPin()
        
        pinNameList.forEach {
            
            geocodeAddressString(address: contents!.contents[$0]!.address, title: $0)
            print("address \(contents!.contents[$0]!.address), title: \($0)")
        }
        
//        geocodeAddressString(address: "서울 성동구 뚝섬로1길 31", title: "M타워")
        
    }
    
    private func geocodeAddressString(address addressString: String, title titleString: String) {
        print("\n---------- [ 주소 -> 위경도 ] ----------")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placeMark, error) in
            if error != nil {
                return print(error!.localizedDescription)
            }
            guard let place = placeMark?.first else { return }
            print(place)
            
            let coordinate = place.location?.coordinate
            
            self.setPin(title: titleString, coordinate: coordinate!)
            
        }
    }

    
    private func setPin(title: String, coordinate: CLLocationCoordinate2D) {

        let setPoint = MKPointAnnotation()
        setPoint.title = title
        setPoint.coordinate = coordinate
        mapView.addAnnotation(setPoint)
        
    }
 

}
