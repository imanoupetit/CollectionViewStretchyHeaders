//
//  CustomFlowLayout.swift
//  StickyHeadersApp
//
//  Created by Imanou on 18/04/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    let margin: CGFloat = 10

    override init() {
        super.init()
        
        sectionInsetReference = .fromSafeArea
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        headerReferenceSize = CGSize(width: 0, height: 80)
        sectionHeadersPinToVisibleBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map({ $0.copy() as! UICollectionViewLayoutAttributes })

        let offsetY = collectionView.contentOffset.y + collectionView.safeAreaInsets.top
        if let firstHeader = rectAttributes.first(where: { $0.representedElementKind == UICollectionElementKindSectionHeader && offsetY < 0}) {
            let origin = CGPoint(x: firstHeader.frame.origin.x, y: firstHeader.frame.minY - offsetY.magnitude)
            let size = CGSize(width: firstHeader.frame.width, height: max(0, headerReferenceSize.height + offsetY.magnitude))
            firstHeader.frame = CGRect(origin: origin, size: size)
        }

        return rectAttributes
    }
    
    /*
     Alternative (does not work properly for multiple section headers)
     Source:  [DIY - Stretchy Headers - Custom Collection View Layouts - raywenderlich.com](https://www.youtube.com/watch?v=faUirawzPaY)
     */
    
    /*
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map({ $0.copy() as! UICollectionViewLayoutAttributes })
        let offsetY = collectionView.contentOffset.y + collectionView.safeAreaInsets.top
        if offsetY < 0 {
            let deltaY = offsetY.magnitude
            for attributes in rectAttributes where attributes.representedElementKind == UICollectionElementKindSectionHeader {
                var frame = attributes.frame
                frame.size.height = max(0, headerReferenceSize.height + deltaY)
                frame.origin.y = frame.minY - deltaY
                attributes.frame = frame
            }
        }
        return rectAttributes
    }
     */
    
    /*
     Alternative (does not work properly for multiple section headers)
     Source:  [StretchyHeaderCollectionViewLayout](https://github.com/nrj/StretchyHeaderCollectionViewLayoutY)
     */
    
    /*
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let insets = collectionView.contentInset
        let offset = collectionView.contentOffset
        let minY = -insets.top - collectionView.safeAreaInsets.top

        if offset.y < minY {
            let headerSize = headerReferenceSize
            let deltaY = (offset.y - minY).magnitude
            for attributes in rectAttributes where attributes.representedElementKind == UICollectionElementKindSectionHeader {
                var headerRect = attributes.frame
                headerRect.size.height = max(minY, headerSize.height + deltaY)
                headerRect.origin.y = headerRect.origin.y - deltaY
                attributes.frame = headerRect
                break
            }
        }

        return rectAttributes
    }
     */
    
}
