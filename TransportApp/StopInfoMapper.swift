//
//  StopInfoMapper.swift
//  TransportApp
//
//  Created by Никита Макаревич on 27.02.2022.
//

import Foundation

func map(stopDetails : RoutePath) -> StopInformationModel {
    return StopInformationModel.init(type: stopDetails.type, number: stopDetails.number, timeInterval: stopDetails.timeArrival)
}
