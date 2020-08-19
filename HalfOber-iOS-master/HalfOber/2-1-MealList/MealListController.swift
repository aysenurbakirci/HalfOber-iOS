//
//  MealListController.swift
//  HalfOber
//
//  Created by Müge EREL on 22.06.2020.
//  Copyright © 2020 HalfOber. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MealListController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var categoryTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var mealList : NSMutableArray = []
    var categoryId : Int = 0
    var categoryName : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        
        categoryTitle.textAlignment = .center
        categoryTitle.text = categoryName
        
        if(ClassReachability.isConnectedToNetwork()){
            GetMealList()
        }
        // Do any additional setup after loading the view.
    }
    
    func GetMealList(){
        spinner.startAnimating()
        spinner.isHidden = false
        AF.request("http://178.62.200.176/api/meals/GetMealsByCategoryId/\(categoryId)").responseJSON { response in switch response.result {
        case .success(let JSON):
            if let response = JSON as? NSArray{
                for i in 0 ..< response.count{
                    let currentMeal = response .object(at: i) as! NSDictionary
                    if let newMeal = Mapper<Meal>().map(JSONObject: currentMeal){
                        self.mealList.add(newMeal)
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
        mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MealCell", bundle: nil), forCellReuseIdentifier: "MealCell")
        let thisCell = tableView.dequeueReusableCell(withIdentifier: "MealCell") as! MealCell
        thisCell.backgroundColor = UIColor.clear
        thisCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if let meal = mealList[indexPath.row] as? Meal{
            let mealName = meal.mealName
            let mealDescription = meal.mealDescription
            //let mealCalory = meal.mealCalory
            let mealPrice = meal.mealPrice
            thisCell.mealName.text = mealName!
            thisCell.mealDescription.text = mealDescription!
            thisCell.mealPrice.text = "\(mealPrice!)"
        }
        return thisCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let meal = self.mealList[(indexPath as NSIndexPath).row] as? Meal{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MealDetailController") as! MealDetailController
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Yemekler", style: UIBarButtonItem.Style.done, target: nil, action: nil)
            vc.mealId = meal.mealId!
            vc.mealName = meal.mealName!
            vc.mealPrice = meal.mealPrice!
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
