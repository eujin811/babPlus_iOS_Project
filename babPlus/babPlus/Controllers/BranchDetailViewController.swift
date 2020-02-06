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
    private let APPDELEGATE = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    lazy var menuArray = APPDELEGATE.dummy?.contents["메타모르포점"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(didTapBackButtonItem(_:)))
        setupUI()
    }
    
    @objc private func didTapBackButtonItem(_ sender : Any) {
        dismiss(animated: true)
    }
    
}

extension BranchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionCheck = section == 0 ? menuArray!.menus.launch.count : menuArray!.menus.dinner.count
        return sectionCheck
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
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

// MARK: - Setup UI
extension BranchDetailViewController {
    
    private func setupMapView() {
        let safeArea = view.safeAreaLayoutGuide
        let mapSize = self.view.frame.height * 0.3
        mapContainerView.addSubview(mapView)
        view.addSubview(mapContainerView)
        
        mapContainerView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(mapCenterlat, mapCenterlon), span: span)
        mapView.setRegion(region, animated: true)
        
        NSLayoutConstraint.activate([
            mapContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapContainerView.heightAnchor.constraint(equalToConstant: mapSize),
            
            mapView.centerXAnchor.constraint(equalTo: mapContainerView.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: mapContainerView.centerYAnchor),
            mapView.widthAnchor.constraint(equalToConstant: mapSize * 1.2),
            mapView.heightAnchor.constraint(equalToConstant: mapSize * 0.9),
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
