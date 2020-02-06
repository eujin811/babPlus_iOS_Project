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
//    private let branchImages = ["가게1", "가게2", "가게3", "가게4", "가게1", "가게2", "가게3", "가게4"]
    private let branchImages = [String]()
    
    lazy var itemCount = branchImages.count
    
//    var tempData: BabMenu?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()

//        request()
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
//        let contentsBody = contents?.contents.index(forKey: branchList[0])
        var contentsBody = contents?.contents["세종타워점"]
//        var contentsBody2 = contents?.contents[branchList[0]]
        
//        contents?.contents.forEach {
//            print("\n content?.contents \($0)")
//        }
        
        branchList.forEach {
            print("contents?.content[$0].image",contents?.contents[$0]?.image)
            
        }
        

        print("branchList[0]의 contents",contentsBody,"\n type: ",type(of: contentsBody))

        print("branchList: \(branchList)")
    }
    
//    private func request() {
//        OperationQueue().addOperation {
//            RequestHelper().reqTask {
//                self.tempData = $0
//                dump(self.tempData)
//
//                //            DispatchQueue.main.async {      //비동기 작업시 데이터를 가져오고 실제로 반영되는 ui작업한느 것들 DispatchMain에서 해줘야.
//                //                self.collectionView.reloadData()
//                //                print("request 완료", self.tempData ?? "실패")
//                //            }
//                OperationQueue.main.addOperation {
//                    print("완료",self.tempData!)
//                }
//            }
//        }
//
//    }
    
    
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
        
//                cell.configure(branchImage: UIImage(named: branchImages[indexPath.item]), branchName: branchImages[indexPath.item])

        cell.configure(branchImage: UIImage(named: branchImages[indexPath.item]), branchName: branchList[indexPath.item])
        
        
        return cell
    }
    
    
    
    
}

// MAKR: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let branchDetailVC = BranchDetailViewController()
        branchDetailVC.modalPresentationStyle = .fullScreen
//        present(branchDetailVC ,animated: true)
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
