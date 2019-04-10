//
//  TM2ToDecimal.swift
//  Coordinate conversion tool
//
//  Created by Louis on 2019/3/18.
//  Copyright © 2019 Louis. All rights reserved.
//

import Foundation

/// TWD67(TM2)轉十進制
func TWD67_TM2ToDecimal(xValue: Double, yValue: Double) -> (Double, Double) {
    
    let a = 6378160.0           // TWD67 6378160.0            TWD97 6378137.0
    let b = 6356774.7192      // TWD67 6356774.7192       TWD97 6356752.314245
    let lng0 = 121 * Double.pi / 180
    let k0 = 0.9999
    let e = pow((1 - pow(b, 2) / pow(a, 2)), 0.5)
    let xValue = xValue - 250000.0
    let yValue = yValue - 0.0
    let mm = yValue / k0
    let mu = mm / (a * (1.0 - pow(e, 2) / 4.0 - 3 * pow(e, 4) / 64.0 - 5 * pow(e, 6) / 256.0))
    let e1 = (1.0 - pow((1.0 - pow(e, 2)), 0.5)) / (1.0 + pow((1.0 - pow(e, 2)), 0.5))
    let j1 = (3 * e1 / 2 - 27 * pow(e1, 3) / 32.0)
    let j2 = (21 * pow(e1, 2) / 16 - 55 * pow(e1, 4) / 32.0)
    let j3 = (151 * pow(e1, 3) / 96.0)
    let j4 = (1097 * pow(e1, 4) / 512.0)
    let fp = mu + j1 * sin(2 * mu) + j2 * sin(4 * mu) + j3 * sin(6 * mu) + j4 * sin(8 * mu)
    let e2 = pow((e * a / b), 2)
    let c1 = pow(e2 * cos(fp), 2)
    let t1 = pow(tan(fp), 2)
    let r1 = a * (1 - pow(e, 2)) / pow((1 - pow(e, 2) * pow(sin(fp), 2)), (3.0 / 2.0))
    let n1 = a / pow((1 - pow(e, 2) * pow(sin(fp), 2)), 0.5)
    let dd = xValue / (n1 * k0)
    let q1 = n1 * tan(fp) / r1
    let q2 = (pow(dd, 2) / 2.0)
    let q3 = (5 + 3 * t1 + 10 * c1 - 4 * pow(c1, 2) - 9 * e2) * pow(dd, 4) / 24.0
    let q4 = (61 + 90 * t1 + 298 * c1 + 45 * pow(t1, 2) - 3 * pow(c1, 2) - 252 * e2) * pow(dd, 6) / 720.0
    var lat = fp - q1 * (q2 - q3 + q4)
    let q5 = dd
    let q6 = (1 + 2 * t1 + c1) * pow(dd, 3) / 6
    let q7 = (5 - 2 * c1 + 28 * t1 - 3 * pow(c1, 2) + 8 * e2 + 24 * pow(t1, 2)) * pow(dd, 5) / 120.0
    var lng = lng0 + (q5 - q6 + q7) / cos(fp)
    // output WGS84(Decimal)
    /// 緯度
    lat = (lat * 180) / Double.pi
    
    /// 經度
    lng = (lng * 180) / Double.pi
    
    return (lng, lat)
}

/// TWD97(TM2)轉十進制
func TWD97_TM2ToDecimal(xValue: Double, yValue: Double) -> (Double, Double) {
    let a = 6378137.0           // TWD67 6378160.0            TWD97 6378137.0
    let b = 6356752.314245      // TWD67 6356774.7192       TWD97 6356752.314245
    let lng0 = 121 * Double.pi / 180
    let k0 = 0.9999
    let e = pow((1 - pow(b, 2) / pow(a, 2)), 0.5)
    let xValue = xValue - 250000.0
    let yValue = yValue - 0.0
    let mm = yValue / k0
    let mu = mm / (a * (1.0 - pow(e, 2) / 4.0 - 3 * pow(e, 4) / 64.0 - 5 * pow(e, 6) / 256.0))
    let e1 = (1.0 - pow((1.0 - pow(e, 2)), 0.5)) / (1.0 + pow((1.0 - pow(e, 2)), 0.5))
    let j1 = (3 * e1 / 2 - 27 * pow(e1, 3) / 32.0)
    let j2 = (21 * pow(e1, 2) / 16 - 55 * pow(e1, 4) / 32.0)
    let j3 = (151 * pow(e1, 3) / 96.0)
    let j4 = (1097 * pow(e1, 4) / 512.0)
    let fp = mu + j1 * sin(2 * mu) + j2 * sin(4 * mu) + j3 * sin(6 * mu) + j4 * sin(8 * mu)
    let e2 = pow((e * a / b), 2)
    let c1 = pow(e2 * cos(fp), 2)
    let t1 = pow(tan(fp), 2)
    let r1 = a * (1 - pow(e, 2)) / pow((1 - pow(e, 2) * pow(sin(fp), 2)), (3.0 / 2.0))
    let n1 = a / pow((1 - pow(e, 2) * pow(sin(fp), 2)), 0.5)
    let dd = xValue / (n1 * k0)
    let q1 = n1 * tan(fp) / r1
    let q2 = (pow(dd, 2) / 2.0)
    let q3 = (5 + 3 * t1 + 10 * c1 - 4 * pow(c1, 2) - 9 * e2) * pow(dd, 4) / 24.0
    let q4 = (61 + 90 * t1 + 298 * c1 + 45 * pow(t1, 2) - 3 * pow(c1, 2) - 252 * e2) * pow(dd, 6) / 720.0
    var lat = fp - q1 * (q2 - q3 + q4)
    let q5 = dd
    let q6 = (1 + 2 * t1 + c1) * pow(dd, 3) / 6
    let q7 = (5 - 2 * c1 + 28 * t1 - 3 * pow(c1, 2) + 8 * e2 + 24 * pow(t1, 2)) * pow(dd, 5) / 120.0
    var lng = lng0 + (q5 - q6 + q7) / cos(fp)
    // output WGS84(Decimal)
    /// 緯度
    lat = (lat * 180) / Double.pi
    
    /// 經度
    lng = (lng * 180) / Double.pi
    
    return (lng, lat)
}
