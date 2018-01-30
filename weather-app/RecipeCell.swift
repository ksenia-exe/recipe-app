//
//  RecipeCell.swift
//  project 7
//
//  Created by Ksenia Zhizhimontova on 11/21/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var ingredientsLabel: UILabel!
    var thumbnailImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        thumbnailImage = UIImageView(frame: CGRect(x: cellMargin, y: cellMargin , width: frame.size.width/4, height: frame.size.width/4))
        thumbnailImage.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(thumbnailImage)
        
        // Display title
        titleLabel = UILabel(frame: CGRect(x: thumbnailImage.frame.maxY + cellMargin*2, y: cellMargin, width: frame.width - 4*cellMargin - cellDateLabelWidth - thumbnailImage.frame.maxY, height: cellTitleLabelHeight))
        titleLabel.font = UIFont(name: "Avenir-Medium", size: 17.0)
        addSubview(titleLabel)
        
        // Display content
        ingredientsLabel = UILabel(frame: CGRect(x: thumbnailImage.frame.maxY + cellMargin*2, y: titleLabel.frame.maxY, width: frame.width - 4*cellMargin - cellDateLabelWidth - thumbnailImage.frame.maxY, height: frame.height - titleLabel.frame.maxY - cellMargin))
        ingredientsLabel.font = UIFont(name: "Avenir-Medium", size: 15.0)
        ingredientsLabel.textColor = UIColor.darkGray
        ingredientsLabel.lineBreakMode = .byWordWrapping
        ingredientsLabel.numberOfLines = 0
        addSubview(ingredientsLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure cell
    func handle(recipe: Recipe) {
        titleLabel.text = recipe.title
        ingredientsLabel.text = recipe.ingredients
        thumbnailImage.image = recipe.thumbnail
    }
    
}
