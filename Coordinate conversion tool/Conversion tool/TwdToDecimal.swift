//
//  TwdToDecimal.swift
//  Coordinate conversion tool
//
//  Created by Louis on 2019/3/18.
//  Copyright © 2019 Louis. All rights reserved.
//

import Foundation

func TWDToDecimal(xDecimal: Double, xMinutes: Double, xSeconds: Double, yDecimal: Double, yMinutes: Double, ySeconds: Double) -> (Double, Double) {
    
    let lng = xDecimal + ((xMinutes / 60) + (xSeconds / 3600))
    let lat = yDecimal + ((yMinutes / 60) + (ySeconds / 3600))
    
    return (lng, lat)
}
