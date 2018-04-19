//
//  HeaderReusableView.swift
//  StickyHeadersApp
//
//  Created by Imanou on 18/04/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .magenta
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
