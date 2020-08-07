//
//  MealCategoryListController.swift
//  HalfOber
//
//  Created by Müge EREL on 21.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MealCategoryListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var mealCategoryList : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)

        
        if(ClassReachability.isConnectedToNetwork()){
            GetMealCategoryList()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func GetMealCategoryList(){
        spinner.startAnimating()
        spinner.isHidden = false
        AF.request("http://178.62.200.176/api/categorys/GetCategoriesByRestaurantId/\((self.tabBarController as! TabBarController).tableId)").responseJSON { response in switch response.result {
        case .success(let JSON):
            if let response = JSON as? NSArray{
                for i in 0 ..< response.count{
                    let currentMealCategory = response .object(at: i) as! NSDictionary
                    if let newMealCategory = Mapper<MealCategory>().map(JSONObject: currentMealCategory){
                        self.mealCategoryList.add(newMealCategory)
                        self.tableView.reloadData()
                    }
                }
            }
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mealCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MealCategoryCell", bundle: nil), forCellReuseIdentifier: "MealCategoryCell")
        let thisCell = tableView.dequeueReusableCell(withIdentifier: "MealCategoryCell") as! MealCategoryCell
        thisCell.backgroundColor = UIColor.clear
        thisCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if let mealCategory = mealCategoryList[indexPath.row] as? MealCategory{
            let categoryName = mealCategory.categoryName
            let categoryDescription = mealCategory.categoryDescription
            thisCell.categoryName.text = "\(categoryName!) \(categoryDescription!)"
        }
        return thisCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mealCategory = self.mealCategoryList[(indexPath as NSIndexPath).row] as? MealCategory{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MealListController") as! MealListController
            //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Yemekler", style: UIBarButtonItem.Style.done, target: nil, action: nil)
            vc.categoryId = mealCategory.categoryId!
            vc.categoryName = mealCategory.categoryName!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        // Remove separator inset
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
}
