//
//  ViewController.swift
//  FlexibleHeader
//
//  Created by Haroldo Gondim on 03/10/17.
//

import UIKit
import MaterialComponents.MaterialFlexibleHeader

class ViewController: UIViewController, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    let flexibleHeaderViewController = MDCFlexibleHeaderViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flexibleHeaderViewController.view.frame = view.bounds
        flexibleHeaderViewController.didMove(toParentViewController: self)
        flexibleHeaderViewController.headerView.trackingScrollView = self.collectionView
        flexibleHeaderViewController.headerView.shiftBehavior = .disabled
        flexibleHeaderViewController.headerView.maximumHeight = 180.0;
        flexibleHeaderViewController.headerView.minimumHeight = 64.0;
        
        let flexibleHeaderView = self.headerView!
        flexibleHeaderView.frame = flexibleHeaderViewController.headerView.bounds
        flexibleHeaderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        flexibleHeaderView.contentMode = .scaleAspectFill
        flexibleHeaderView.clipsToBounds = true
        
        flexibleHeaderViewController.headerView.insertSubview(flexibleHeaderView, at: 0)
        view.addSubview(flexibleHeaderViewController.view)
        
        //With the code line below the issue reproduces
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == flexibleHeaderViewController.headerView.trackingScrollView {
            flexibleHeaderViewController.headerView.trackingScrollDidScroll()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == flexibleHeaderViewController.headerView.trackingScrollView {
            flexibleHeaderViewController.headerView.trackingScrollDidEndDecelerating()
        }
    }

}
