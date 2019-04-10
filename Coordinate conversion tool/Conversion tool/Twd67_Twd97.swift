//
//  Twd67_Twd97.swift
//  Coordinate conversion tool
//
//  Created by Louis on 2019/3/18.
//  Copyright © 2019 Louis. All rights reserved.
//

import Foundation

let a = 0.00001549, b = 0.000006521
//    TWD67<->TWD97 二度分帶二維坐標轉換公式
//    x67 = x97 - 807.8 - a * x97 - b * y97
//    y67 = y97 + 248.6 - a * y97 - b * x97
//    x97 = x67 + 807.8 + a * x67 + b * y67
//    y97 = y67 - 248.6 + a * y67 + b * x67

/// 取得TWD67(TM2)座標
func TWD67_TM2(x97: Double, y97: Double) -> (Double, Double) {
    let coordinate_X = x97 - 807.8 - a * x97 - b * y97
    let coordinate_Y = y97 + 248.6 - a * y97 - b * x97
    
    return (coordinate_X, coordinate_Y)
}

/// 取得TWD97(TM2)座標
func TWD97_TM2(x67: Double, y67: Double) -> (Double, Double) {
    let coordinate_X = x67 + 807.8 + a * x67 + b * y67
    let coordinate_Y = y67 - 248.6 + a * y67 + b * x67
    
    return (coordinate_X, coordinate_Y)
}


