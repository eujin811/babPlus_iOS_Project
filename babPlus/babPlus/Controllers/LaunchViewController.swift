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
//    let APPDELEGATE = UIApplication.shared.delegate as!
//    AppDelegate
    
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
        
        let margin:CGFloat = 10
        
        let dishesYSet:CGFloat = 7
        
        let forkWidht:CGFloat = 155
        let forkHeight:CGFloat = 290
        
        let spoonWidth:CGFloat = 160
        let spoonHeight:CGFloat = 210

        
        [logoImage, forkImage, spoonImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: logoWidth),
            logoImage.heightAnchor.constraint(equalToConstant: logoHegiht),
            
            forkImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: dishesYSet),
            forkImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(margin - 3)),
//            forkImage.trailingAnchor.constraint(equalTo: logoImage.leadingAnchor, constant: imagePadding),
            forkImage.widthAnchor.constraint(equalToConstant: forkWidht),
            forkImage.heightAnchor.constraint(equalToConstant: forkHeight),
            
            spoonImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -dishesYSet),
            spoonImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin - (spoonWidth - forkWidht)),
//            spoonImage.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: imagePadding),
            spoonImage.widthAnchor.constraint(equalToConstant: spoonWidth),
            spoonImage.heightAnchor.constraint(equalToConstant: forkHeight)
            
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
