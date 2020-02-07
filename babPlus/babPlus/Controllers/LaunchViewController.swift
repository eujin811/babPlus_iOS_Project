//
//  LaunchViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/06.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    let APPDELEGATE = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    private let logoImage = UIImageView()
    private let forkImage = UIImageView()
    private let spoonImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        attribute()
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let mainVC = MainViewController()
        let mainMapVC = BranchsAddressMapViewController()
        let mainNaviController = UINavigationController(rootViewController: mainVC)
        let mapNaviController = UINavigationController(rootViewController: mainMapVC)
        mainNaviController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        mapNaviController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNaviController, mapNaviController]
        
        RequestHelper().reqTask(path: "menu", method: "GET") {
            (result) in
            self.APPDELEGATE.dummy = result
            DispatchQueue.main.async {
                self.APPDELEGATE.window?.rootViewController = tabBarController
            }


        }
        
        
    }
    
    
    private func setupUI() {
        
        let logoWidth:CGFloat = 265
        let logoHegiht:CGFloat = 244
        let imagePadding:CGFloat = 30
        
        let margin:CGFloat = 50
        
        
        let dishiesWidht:CGFloat = 120
        let spoonHeight:CGFloat = 230
        let forkheight:CGFloat = 250
        


        
        [logoImage, forkImage, spoonImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: logoWidth),
            logoImage.heightAnchor.constraint(equalToConstant: logoHegiht),
            
            forkImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            forkImage.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: -margin),
            forkImage.widthAnchor.constraint(equalToConstant: dishiesWidht),
            forkImage.heightAnchor.constraint(equalToConstant: forkheight),
            
            spoonImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spoonImage.trailingAnchor.constraint(equalTo: logoImage.leadingAnchor, constant: margin),

            spoonImage.widthAnchor.constraint(equalToConstant: dishiesWidht),
            spoonImage.heightAnchor.constraint(equalToConstant: spoonHeight)
            
        ])
        NSLayoutConstraint.activate([
            
        ])
        print("setUI")
    }
    
    private func attribute() {
        logoImage.image = UIImage(named: "logo")
        forkImage.image = UIImage(named: "fork")
        spoonImage.image = UIImage(named: "SPOON")
        
        view.addSubview(logoImage)
        view.addSubview(forkImage)
        view.addSubview(spoonImage)
    }


}
