//
//  const.swift
//  project 7
//
//  Created by Ksenia Zhizhimontova on 11/21/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Blue color for the entire app. We put it in extension to use it everywhere and
    // maintain consistency. We can easily change it by changing the values here instead
    // of trying to change it everywhere we use it.
    class var blogBlue: UIColor {
        return UIColor(red:143/255, green:145/255, blue:244/255, alpha:1.00)
    }
    
    // Background color for collection view
    class var collectionViewBackground: UIColor {
        return UIColor(white: 0.96, alpha: 1.0)
    }
}

// Collection view design constants
let collectionViewCellMargin: CGFloat = 8.0
let collectionViewCellSpacing: CGFloat = 8.0

let cellMargin: CGFloat = 8.0
let cellTitleLabelHeight: CGFloat = 24.0
let cellAuthorLabelHeight: CGFloat = 14.0
let cellDateLabelWidth: CGFloat = 66.0
