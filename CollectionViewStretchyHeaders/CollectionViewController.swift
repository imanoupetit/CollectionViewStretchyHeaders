//
//  CollectionViewController.swift
//  StickyHeadersApp
//
//  Created by Imanou on 17/04/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let idealCellWidth: CGFloat = 100
    let flowLayout = CustomFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let collectionView = collectionView else { fatalError() }
        
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(CyanCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderReusableView
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CyanCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let availableWidth = collectionView.frame.width - collectionView.safeAreaInsets.left - collectionView.safeAreaInsets.right - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        let idealNumberOfCells = (availableWidth + flowLayout.minimumInteritemSpacing) / (idealCellWidth + flowLayout.minimumInteritemSpacing)
        let numberOfCells = idealNumberOfCells.rounded(.down)
        let cellWidth = (availableWidth + flowLayout.minimumInteritemSpacing) / numberOfCells - flowLayout.minimumInteritemSpacing
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
}
