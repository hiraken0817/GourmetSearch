//
//  SearchRestaurantViewController.swift
//  SearchRestaurant
//
//  Created by 平尾健太 on 2021/05/08.
//

import UIKit
import CoreLocation

final class SearchRestaurantViewController: UIViewController{
    
    
    @IBOutlet var rangeTextField: UITextField!
    
    @IBOutlet var baseView: UIView!
    
    @IBAction func SearchButton(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "ResultListViewController", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "ResultListViewController") as! ResultListViewController
       
        //ResultListViewControllerに渡す情報
        nextView.range = String(describing: range)
        nextView.lat = lat
        nextView.lng = lng
        
        self.navigationController?.pushViewController(nextView, animated: true)//遷移する
    }
    
    var locationManager = CLLocationManager()
    
    // pickerViewに表示させる検索半径
    let pickRange = ["現在地より300m圏内" , "現在地より500m圏内" , "現在地より1km圏内" , "現在地より2km圏内" , "現在地より3km圏内"]
    
    var range:Int = 1//初期値を"現在地より300m圏内"とする
    
    var lat:Double? = 34.67
    var lng:Double? = 135.52//大阪の座標
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.layer.cornerRadius = 25
        
        setupLocationManager()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    
        rangeTextField.inputView = pickerView
        
        rangeTextField.text = "現在地より300m圏内"
        rangeTextField.tintColor = UIColor.clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension SearchRestaurantViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        lat = latitude
        lng = longitude
    }
}

extension SearchRestaurantViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickRange[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rangeTextField.text = pickRange[row]
        rangeTextField.resignFirstResponder()
        
        range = row + 1
        
    }
    
}
