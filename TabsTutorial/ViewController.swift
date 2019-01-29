//
//  ViewController.swift
//  TabsTutorial
//
//  Created by Jayesh Sharma on 04/08/18.
//  Copyright © 2018 HobbyDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tabsViewer: UIView!
    @IBOutlet weak var tabNamesCV: UICollectionView!
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    //Tabs collection view ID
    var id = "identifier"
    //Tab name collection view ID
    var tabNameID = "TabNameID"
    
    //Horizontal scrolling view
    var tabIndicator:UIView!
    
    //Dummie tab count
    var tabCount:CGFloat = 4.0
    
    fileprivate func setupTabsCollectionView() {
        let nib = UINib.init(nibName: "CollectionCell", bundle: nil)
        collectionVIew.register(nib, forCellWithReuseIdentifier: id)
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        collectionVIew.isPagingEnabled = true
        let lut = UICollectionViewFlowLayout.init()
        lut.scrollDirection = .horizontal;
        lut.itemSize =  CGSize.init(width: collectionVIew.bounds.width, height: collectionVIew.bounds.height)
        collectionVIew.collectionViewLayout = lut
    }
    
    fileprivate func setupTabIndicatorCollectionVIew() {
        let tabNameNib = UINib.init(nibName: "TabNamesCollectionViewCell", bundle: nil)
        tabNamesCV.register(tabNameNib, forCellWithReuseIdentifier: tabNameID)
        tabNamesCV.delegate = self
        tabNamesCV.dataSource = self
        let lut1 = UICollectionViewFlowLayout.init()
        lut1.scrollDirection = .horizontal
        lut1.itemSize = CGSize.init(width: tabNamesCV.bounds.width/tabCount, height:     tabNamesCV.bounds.height)
        // comment above line and uncomment line below to get full size tab names
        //lut1.estimatedItemSize = CGSize.init(width: 5, height: tabNamesCV.bounds.height)
        tabNamesCV.collectionViewLayout = lut1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabIndicatorCollectionVIew()
        
        setupTabHorizontalIndicator()
        
        setupTabsCollectionView()

    }
    
    func setupTabHorizontalIndicator() {
        tabIndicator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.collectionVIew.bounds.width/tabCount, height: tabsViewer.bounds.height))
        tabIndicator.backgroundColor = UIColor.cyan
        self.tabsViewer.addSubview(tabIndicator)
        
    }
    
    /// Add Viewcontroller to cell
    ///
    /// - Parameter cell: CollectionView Cell
    /// - Returns:CollectionView Cell
    func addVC(cell:CollectionCell)->CollectionCell{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabVCID")
        vc?.view.frame = cell.holderChild.bounds
        cell.holderChild.addSubview((vc?.view)!)
        self.addChildViewController(vc!)
        vc?.didMove(toParentViewController: self)
        return cell
        
        
    }
    
}
extension ViewController:UIScrollViewDelegate {
    
    //Move horizontal view on scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.1, animations: {
            self.tabIndicator.frame.origin.x = scrollView.contentOffset.x/self.tabCount
            
        })
        
        
        
    }
    
}

extension ViewController :
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return   Int.init(tabCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabNamesCV {
            return CGSize.init(width: tabNamesCV.bounds.width/tabCount, height:     tabNamesCV.bounds.height)
            
        }
        return CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabNamesCV {
            collectionVIew.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionVIew {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! CollectionCell
            return addVC(cell: cell)
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabNameID, for: indexPath) as! TabNamesCollectionViewCell
            cell.tabNameLbl.text = "Tab \(indexPath.row)"
            return cell
        }
        
    }
    
    
}
