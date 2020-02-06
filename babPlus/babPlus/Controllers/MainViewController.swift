//
//  ViewController.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
    
    
    private var contents:BabMenu?
    private var branchList = [String]()
//  private let branchImagesURL = ["가게1", "가게2", "가게3", "가게4", "가게1", "가게2", "가게3", "가게4"]
    private var branchImagesURL = [String]()
    
    lazy var itemCount = branchImagesURL.count
    
    //    var tempData: BabMenu?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        
        searchBarSet()
        setupCollectionView()
        
    }
    private func requestData() {
        let APPDELEGATE = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        contents = APPDELEGATE.dummy!.self as! BabMenu
        
        let keys = contents?.contents.keys
        print("contents",contents?.contents)
        
        keys?.forEach {
            branchList.append($0)
        }
        
        //imageURL
        branchList.forEach {
            print("contents?.content[$0].image",contents?.contents[$0]?.image)
            print("image type ",type(of: contents?.contents[$0]?.image))
            branchImagesURL.append((contents?.contents[$0]?.image ?? ""))
        }
        
        print("branchList: \(branchList)")
    }
    
    
    
    private func searchBarSet() {
        //        searchController.searchBar.tintColor = .init(red: 255, green: 246, blue: 18, alpha: 1)
        //        searchController.searchBar.placeholder = "상호명을 검색하세요."
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        setupFlowLayout()
        
        collectionView.backgroundColor = .white
        collectionView.register(MainBranchCollectionViewCell.self, forCellWithReuseIdentifier: MainBranchCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    private func setupFlowLayout() {
        //flowLayout
        let padding:CGFloat = 10
        let margin:CGFloat = 20
        let itemCount:CGFloat = 2
        let frameWidth = view.frame.width
        
        let contentWidth:CGFloat = frameWidth - (margin * 2) - (padding * (itemCount - 1))
        let itemWidth:CGFloat = (contentWidth / itemCount).rounded(.down)
        
        
        flowLayout.minimumInteritemSpacing = padding
        flowLayout.minimumLineSpacing = padding
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainBranchCollectionViewCell.identifier, for: indexPath) as! MainBranchCollectionViewCell
        cell.backgroundColor = .white
        


        cell.configure(branchImageURL: branchImagesURL[indexPath.item], branchName: branchList[indexPath.item])
        
        
        return cell
    }
    
    
}

// MAKR: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let branchDetailVC = BranchDetailViewController()
        branchDetailVC.modalPresentationStyle = .fullScreen
        //        present(branchDetailVC ,animated: true)
        
        /*
         let receiveAddress = ""
         let receiveBranchName = ""
         */
        branchDetailVC.receiveBranchName = branchList[indexPath.item]
        branchDetailVC.receiveAddress = (contents?.contents[branchList[indexPath.item]]?.address)!
        self.navigationController?.pushViewController(branchDetailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        print(searchText)
    }
}
