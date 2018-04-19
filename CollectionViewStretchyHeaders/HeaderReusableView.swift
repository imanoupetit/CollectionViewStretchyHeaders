//
//  HeaderReusableView.swift
//  StickyHeadersApp
//
//  Created by Imanou on 18/04/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .magenta
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
