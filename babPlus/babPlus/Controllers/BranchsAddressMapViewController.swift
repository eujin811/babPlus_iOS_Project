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
    
    private let pinList = [
        "메타모르포점":"서울 성동구 성수일로 89 메타모르포",
        "코오롱디지털타워3차점":"서울 성동구 아차산로 49 코오롱타워 3차",
        "M타워점":"서울 성동구 뚝섬로1길 31 서울숲 M타워",
        "세종타워점":"서울 성동구 성수일로10길 26 하우스디세종타워",
        "SKV1":"서울 성동구 연무장5가길 25",
        "Sol623타워점":"서울 성동구 상원1길 25",
        "롯데 IT캐슬점":"서울 성동구 광나루로 130",
        "에이팩 센터":"서울 성동구 아차산로7나길 18",
        "성수타워점":"서울 성동구 성수이로10길 14",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
//        setRgion(coordinate: mapCenter)
        attribute()
        setupUI()
    }
    
    private func setRgion(coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func setupUI() {
        
    }
    
    private func attribute() {
        setRgion(coordinate: mapCenter)
        setPin()
        
    }
    
    private func setPin() {
        pinList.forEach{
            let setPoint = MKPointAnnotation()
            setPoint.title = $0.key
//            setPoint.coordinate = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        }
        
    }
 

}
