//
//  Extension.swift
//  SearchRestaurant
//
//  Created by 平尾健太 on 2021/05/09.
//

import UIKit

//MARK:レイアウトに関するExtension
extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom:NSLayoutYAxisAnchor?,
                right:NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft:CGFloat,
                paddingBottom:CGFloat,
                paddingRight:CGFloat,
                width:CGFloat,
                height:CGFloat){
        
        self.translatesAutoresizingMaskIntoConstraints = false//AutoresizingMaskの設定値をAuto Layoutの制約に変換しない
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left{
            self.leftAnchor.constraint(equalTo: left,constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right{
            self.rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
        }
        
        if width != 0{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}




