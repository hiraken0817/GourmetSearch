//
//  Shop.swift
//  SearchRestaurant
//
//  Created by 平尾健太 on 2021/05/08.
//

import Foundation

struct Results: Codable {
    let results:Result
}

struct Result:Codable{
//    let api_version:String
    let shop:[Shop]
    let results_available:Int?
    
}

struct Shop:Codable{
    
    let id:String?
    let name:String?//店名
    let mobile_access:String?
    let address:String?
    let budget:Budget
    let card:String?
    let open:String?
    let `catch`:String?
    let close:String?
    let genre:Genre
    let middle_area:MiddleArea//市や区
    let photo:Photo
    let lat:Double?//緯度
    let lng:Double?//軽度
    
}

struct Budget:Codable {
    
    let average:String?//平均予算
    
}

struct Genre:Codable {
    let name:String?//ジャンル名
    
}

struct MiddleArea:Codable {
    let name:String?
}

struct Photo:Codable{
    let mobile:Mobile?
    let pc:Pc?
}

struct Mobile:Codable {
    let l:String?//画像のurl（小）
}

struct Pc:Codable {
    let l:String?//画像のurl（大）
}
