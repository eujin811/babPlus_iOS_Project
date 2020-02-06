//
//  BranchDetailViewController.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit
import MapKit

class BranchDetailViewController: UIViewController {
    
    private let backButtonItem = UINavigationItem()
    private let mapView = MKMapView()
    private let mapContainerView = UIView()
    private let menuTableView = UITableView()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = self.APPDELEGATE.dummy?.date as! String
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
    private let APPDELEGATE = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    lazy var menuArray = APPDELEGATE.dummy?.contents["코오롱디지털타워3차점"]
    
    let receiveAddress = "주소주소주소"
    let receiveBranchName = "코오롱디지털타워3차점"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = receiveBranchName
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(didTapBackButtonItem(_:)))
        setupUI()
    }
    
    @objc private func didTapBackButtonItem(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true)
    }
    
}

extension BranchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCheck = section == 0 ? menuArray!.menus.launch.count : menuArray!.menus.dinner.count
        return sectionCheck
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 0
        if !menuArray!.menus.launch.isEmpty {
            sectionCount += 1
        }
        if !menuArray!.menus.dinner.isEmpty {
            sectionCount += 1
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionOfString = section == 0 ? "점심" : "저녁"
        return sectionOfString
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "qwe") ?? UITableViewCell()
        if indexPath.section == 0 {
            cell.textLabel?.text = menuArray!.menus.launch[indexPath.row]
        } else {
            cell.textLabel?.text = menuArray!.menus.dinner[indexPath.row]
        }
        
        return cell
    }
}


// MARK: - mapViewPin
//extension BranchDetailViewController {
//    let location = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)

//}

// MARK: - Setup UI
extension BranchDetailViewController {
    private func setupMapView() {
        let safeArea = view.safeAreaLayoutGuide
        let mapSize = self.view.frame.height * 0.3
        [mapView].forEach {
            mapContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        mapView.addSubview(dateLabel)
        view.addSubview(mapContainerView)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        mapContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(mapCenterlat, mapCenterlon), span: span)
        mapView.setRegion(region, animated: true)
        
        NSLayoutConstraint.activate([
            mapContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapContainerView.heightAnchor.constraint(equalToConstant: mapSize),
            
            dateLabel.topAnchor.constraint(equalTo: mapView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            
            mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: mapSize * 1),
            
        ])
    }
    
    private func setupTableView() {
        let safeArea = view.safeAreaLayoutGuide
        [menuTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: mapContainerView.bottomAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
    private func setupUI() {
        setupMapView()
        setupTableView()
        menuTableView.dataSource = self
    }
}
