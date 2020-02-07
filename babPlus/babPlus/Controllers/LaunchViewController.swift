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
        self.spoonImage.contentMode = .scaleAspectFit
        self.forkImage.contentMode = .scaleAspectFit
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
        
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -27)
                self.forkImage.transform = .init(rotationAngle: .pi / 27)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -18)
                self.forkImage.transform = .init(rotationAngle: .pi / 18)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.75) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -27)
                self.forkImage.transform = .init(rotationAngle: .pi / 27)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -18)
                self.forkImage.transform = .init(rotationAngle: .pi / 18)
            }
        })
        
    }
    
    
    private func setupUI() {
        
        let logoWidth:CGFloat = 265
        let logoHegiht:CGFloat = 244
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
            
            forkImage.centerYAnchor.constraint(equalTo: logoImage.bottomAnchor),
            forkImage.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: -margin),
            forkImage.widthAnchor.constraint(equalToConstant: dishiesWidht),
//            forkImage.heightAnchor.constraint(equalToConstant: forkheight),
            
            spoonImage.centerYAnchor.constraint(equalTo: logoImage.bottomAnchor),
            spoonImage.trailingAnchor.constraint(equalTo: logoImage.leadingAnchor, constant: margin),
            
            spoonImage.widthAnchor.constraint(equalToConstant: dishiesWidht),
//            spoonImage.heightAnchor.constraint(equalToConstant: spoonHeight)
            
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
