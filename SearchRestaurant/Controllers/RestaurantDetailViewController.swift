//
//  RestaurntDetailViewController.swift
//  SearchRestaurant
//
//  Created by 平尾健太 on 2021/05/08.
//

import UIKit
import Nuke
import MapKit
import CoreLocation

final class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var catchLabel: UILabel!
    @IBOutlet var shopNameLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var middleAreaLabel: UILabel!
    @IBOutlet var thinShopNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var accessLabel: UILabel!
    @IBOutlet var openLabel: UILabel!
    @IBOutlet var closeLabel: UILabel!
    @IBOutlet var budgetAverageLabel: UILabel!
    @IBOutlet var cardLabel: UILabel!
    @IBOutlet var baseView: UIView!
    @IBOutlet var shopMap: MKMapView!
    
    let backScreenButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(backScreen), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .darkGray
        button.backgroundColor = .white
        
        button.alpha = 0.8;
        return button
    }()
    
    //モーダルを閉じる処理
    @objc func backScreen(){
        dismiss(animated: true, completion: nil)
    }
    
    var shop = [Shop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.layer.cornerRadius = 4
        
        setupInfo()//情報の取得
        
        setupMap()
        
    }
    
    //閉じるボタンを左上に固定
    private func setupBackScreenButton(){
        view.addSubview(backScreenButton)
        backScreenButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        backScreenButton.layer.cornerRadius = 20
    }
    
    private func setupMap(){
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        // 位置情報をセット
        let location = CLLocationCoordinate2DMake(shop[0].lat! , shop[0].lng!)
        // centerに東京駅のlocationDataをセット
        let region = MKCoordinateRegion(center: location, span: span)
        shopMap.region = region
        
        let coordinate =  CLLocationCoordinate2DMake(shop[0].lat! , shop[0].lng!)
        
        // ピンを生成
        let pin = MKPointAnnotation()
        // ピンのタイトル・サブタイトルをセット
        pin.title = shop[0].name
        
        // ピンに一番上で作った位置情報をセット
        pin.coordinate = coordinate
        // mapにピンを表示する
        shopMap.addAnnotation(pin)
    }
    
    private func setupInfo(){
        if let url = URL(string: shop[0].photo.pc?.l ?? ""){
            Nuke.loadImage(with: url, into: logoImageView)
        }
        
        catchLabel.text = shop[0].catch
        shopNameLabel.text = shop[0].name
        genreLabel.text = shop[0].genre.name
        middleAreaLabel.text = shop[0].middle_area.name
        thinShopNameLabel.text = shop[0].name
        addressLabel.text = shop[0].address
        accessLabel.text = shop[0].mobile_access
        openLabel.text = shop[0].open
        closeLabel.text = shop[0].close
        budgetAverageLabel.text = shop[0].budget.average
        cardLabel.text = shop[0].card
    }
    
    
}


