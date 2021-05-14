//
//  RestaurantListTableViewCell.swift
//  SearchRestaurant
//
//  Created by 平尾健太 on 2021/05/05.
//

import UIKit
import Nuke

class RestaurantListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var catchLabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var middleAreaLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet var baseView: UIView!
    @IBOutlet var genreView: UIView!
    
    var shopItems:Shop?{
        didSet{
            
            if let url = URL(string: shopItems?.photo.mobile?.l ?? ""){
                Nuke.loadImage(with: url, into: logoImageView)
            }
            
            catchLabel.text = shopItems?.catch
            shopNameLabel.text = shopItems?.name
            genreLabel.text = shopItems?.genre.name
            middleAreaLabel.text = shopItems?.middle_area.name
            accessLabel.text = shopItems?.mobile_access
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        baseViewRayout()
        genreView.layer.cornerRadius = 3
        
    }
    
    //baseView影をつける処理
    private func baseViewRayout(){
        //影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        baseView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        // 影の色
        baseView.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        baseView.layer.shadowOpacity = 0.2
        // 影をぼかし
        baseView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
