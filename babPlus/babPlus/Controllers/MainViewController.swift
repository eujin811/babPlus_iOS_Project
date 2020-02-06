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
    private var branchImagesURL = [String]()
    
    lazy var itemCount = branchImagesURL.count
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        
        searchBarSet()
        setupCollectionView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        collectionViewInitialization()
        
    }
    
    
    private func requestData() {
        let APPDELEGATE = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        contents = APPDELEGATE.dummy!.self
        
        let keys = contents?.contents.keys
        
        keys?.forEach {
            branchList.append($0)
        }
        
        //imageURL
        branchList.forEach {
            branchImagesURL.append((contents?.contents[$0]?.image ?? ""))
        }
        
    }
    
    // MARK: - collectionView 초기화
    private func collectionViewInitialization() {
        branchList.removeAll()
        branchImagesURL.removeAll()
        
        requestData()
        
        itemCount = branchImagesURL.count
        
        collectionView.reloadData()
    }
    
    
    private func searchBarSet() {

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


// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("-----------numberOfItemInSection---------------")
        print("itemCount \(itemCount)")
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainBranchCollectionViewCell.identifier, for: indexPath) as! MainBranchCollectionViewCell
        cell.backgroundColor = .white
        
        cell.configure(branchImageURL: branchImagesURL[indexPath.item], branchName: branchList[indexPath.item])
        print("--------------cellForItemAt---------------")
        print("branchImageURL: \(branchImagesURL), branchName: \(branchList)")
        return cell
    }
    
    
}

// MAKR: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let branchDetailVC = BranchDetailViewController()
        branchDetailVC.modalPresentationStyle = .fullScreen
        
        branchDetailVC.receiveBranchName = branchList[indexPath.item]
        branchDetailVC.receiveAddress = (contents?.contents[branchList[indexPath.item]]?.address)!
        self.navigationController?.pushViewController(branchDetailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    // MARK: - searchBar 검색
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        
        if searchText.count >= 2 {
            print(searchText)
            print(searchText.count)
            
            var swapList = [String]()
            
            print("branchList.contains",branchList.contains(searchText))
            
            //            branchList.forEach {
            contents!.contents.keys.forEach {
                print("branchList forEach",$0.contains(searchText))
                if $0.contains(searchText) {
                    swapList.append($0)
                }
            }
            
            branchList.removeAll()
            branchImagesURL.removeAll()
            swapList.forEach {
                branchList.append($0)
                branchImagesURL.append((contents?.contents[$0]?.image ?? ""))
            }
            
            itemCount = branchImagesURL.count
            
            print("branchList : \(branchList) \n branchImageURL: \(branchImagesURL)")
            collectionView.reloadData()
            //branchImagesURL
            
            
        }
    }
    
    // MARK: - cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionViewInitialization()
    }
    
}
