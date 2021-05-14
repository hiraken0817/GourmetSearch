//
//  ViewController.swift
//  SearchRestaurant
//
//  Created by 平尾健太 on 2021/05/03.
//

import UIKit
import Alamofire

final class ResultListViewController: UIViewController{
    
    private let cellId = "cellId"
    private var shopItems = [Shop]()
    var lat:Double?
    var lng:Double?
    var range:String = "1"
    
    @IBOutlet weak var restaurantListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        restaurantListTableView.delegate = self
        restaurantListTableView.dataSource = self
        restaurantListTableView.register(UINib(nibName: "RestaurantListTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        fetchHPGSearchInfo()
        
    }
    
    private func fetchHPGSearchInfo(){
        
        // keys.plistからapiキー取得
        let filePath = Bundle.main.path(forResource: "keys", ofType:"plist" )
        let plist = NSDictionary(contentsOfFile: filePath!)
        let api = plist!["apiKey"]!
        
        guard let url = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(api)&lat=\(String(describing: lat!))&lng=\(String(describing: lng!))&range=\(range)&order=4&format=json") else { return }
    
        let request = AF.request(url)
    
        request.responseJSON{ (response) in
            do{
            guard let data = response.data else { return }
            let decode = JSONDecoder()
            let shop = try decode.decode(Results.self,from: data)
                
                self.shopItems = shop.results.shop
                self.navigationItem.title = "検索結果:\(String(describing: shop.results.results_available!))件"
                self.restaurantListTableView.reloadData()
            
            }catch{
                print("変換に失敗しました: ",error)
            }
        }
    }
}

extension ResultListViewController:  UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopItems.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RestaurantListTableViewCell
        
        cell.shopItems = shopItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = shopItems[indexPath.item]//選択されたセルの情報
     
        // 名前を指定してStoryboardを取得する(Fourth.storyboard)
        let storyboard: UIStoryboard = UIStoryboard(name: "RestaurantDetailViewController", bundle: nil)
        
        // StoryboardIDを指定してViewControllerを取得する(FourthViewController)
        let restaurantDetailViewController = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
        restaurantDetailViewController.shop = [shop]//restaurantControllerに渡す
        
        self.present(restaurantDetailViewController, animated: true, completion: nil)
    }
    
}
