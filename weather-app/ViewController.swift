//
//  ViewController.swift
//  project 7
//
//  Created by Ksenia Zhizhimontova on 11/21/17.
//  Copyright © 2017 ksenia. All rights reserved.
//
import Alamofire
import SwiftyJSON
import UIKit

class RecipeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,  UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    var recipies: [Recipe] = []
    
    var collectionView: UICollectionView!
    var emptyLabel: UILabel!
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    //var searchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigation title
        title = "Puppy Recipies"
        
        // Set background color
        view.backgroundColor = .white
        
        // Call setup methods
        setupCollectionView()

        
        // Request posts from the network
        getRecipies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the frame any time the view's frame changes
        collectionView.frame = view.bounds
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
        print("cancelled")
    }
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        RecipeViewController.getUpdatedRecipe(searchString: searchString){recipies in
            self.recipies = recipies
            
            self.updateCollectionView()
        }
        
        collectionView.reloadData()
        
    }
    static func getUpdatedRecipe(searchString: String?, completion: @escaping ([Recipe])-> Void){
        
        let hostURL = "http://www.recipepuppy.com/api/?i="
        guard let url = URL(string: hostURL + searchString!) else {return}
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json["results"].arrayValue
                var recipies: [Recipe] = []
                for json in jsonArray{
                    recipies.append(Recipe(json:json))
                }
                completion(recipies)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        collectionView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            collectionView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Setup Views
    
    func setupCollectionView() {
        
        // Create and customize collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - collectionViewCellMargin * 2, height: 125.0)
        layout.minimumLineSpacing = collectionViewCellSpacing
        layout.sectionInset.top = collectionViewCellMargin
        layout.sectionInset.bottom = collectionViewCellMargin * 2
        
        // Create collection view with the view's frame and the layout we created
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .collectionViewBackground
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "RecipeCell")
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        // Create pull to refresh view and set it to the collection view's pull to refresh view
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getRecipies), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        // Create empty label and put it in the center of the view
        emptyLabel = UILabel()
        emptyLabel.font = UIFont(name: "Avenir-Medium", size: 24.0)
        emptyLabel.textColor = .lightGray
        
        emptyLabel.text = "No Recipies Found"
        emptyLabel.sizeToFit()
        emptyLabel.center = CGPoint(x: view.center.x, y: view.center.y - (navigationController?.navigationBar.frame.maxY ?? 0.0))
        view.addSubview(emptyLabel)
        
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for recipies"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        
        
        
        self.navigationItem.titleView = searchController.searchBar
    }
    

    
    // MARK: Action Targets
    
    static func getRecipe(completion: @escaping ([Recipe])-> Void){
        
        let hostURL = "http://www.recipepuppy.com/api/"
        guard let url = URL(string: hostURL) else {return}
        Alamofire.request(url).validate().responseJSON{response in
            switch response.result{
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json["results"].arrayValue
                var recipies: [Recipe] = []
                for json in jsonArray{
                    recipies.append(Recipe(json:json))
                }
                completion(recipies)
                    
            case .failure(let error):
                print(error)
            }
        }
    
    }

    
    @objc func getRecipies() {
        
        RecipeViewController.getRecipe{recipies in
            self.recipies = recipies
            
            self.updateCollectionView()
        }
        
    }
    func updateCollectionView() {
        

        // Reload collection view with fade animation (equivalent to collectionView.reloadData()
        collectionView.reloadSections(IndexSet(integer: 0))
        
        // Set empty label to hidden if there are no posts
        emptyLabel.isHidden = !recipies.isEmpty
        
        // Stop refreshing animation
        collectionView.refreshControl?.endRefreshing()
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        // Get proper post
        let recipe = recipies[indexPath.item]
        
        // Configure cell for the given post
        cell.handle(recipe: recipe)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        // Push post detail view controller
//        let postDetailViewController = PostDetailViewController(post: posts[indexPath.item])
//        navigationController?.pushViewController(postDetailViewController, animated: true)
//    }
    
}

