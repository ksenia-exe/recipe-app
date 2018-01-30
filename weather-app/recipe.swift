//
//  recipe.swift
//  project 7
//
//  Created by Ksenia Zhizhimontova on 11/21/17.
//  Copyright © 2017 ksenia. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Recipe {
    
    
    // The title of the blog post
    var title: String
    
    // The content of the post
    var ingredients: String
    var thumbnail: UIImage
    
   
    init(json: JSON){
        title = json["title"].stringValue
        ingredients = json["ingredients"].stringValue
        let url = URL(string: json["thumbnail"].stringValue)
        if json["thumbnail"].stringValue == ""{
            thumbnail = UIImage(named: "default")!
        }
        else{
            
            let data = try? Data(contentsOf: url!)
            thumbnail = UIImage(data: data!)!
        }
    }
}
