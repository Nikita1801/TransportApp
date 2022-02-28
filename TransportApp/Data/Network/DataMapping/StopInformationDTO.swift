//
//  StopInformationDTO.swift
//  TransportApp
//
//  Created by Никита Макаревич on 26.02.2022.
//

import Foundation

struct StopInformationDTO : Codable {
    let routePath : [RoutePath]
}
struct RoutePath : Codable {
    let type : String
    let number : String
    let timeArrival : [String]
}
