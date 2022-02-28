//
//  StopInformationRepostory.swift
//  TransportApp
//
//  Created by Никита Макаревич on 26.02.2022.
//

import Foundation
protocol StopInformationRepositoryDelegate {
    func didUpdateStopInfo(_ topInformationRepository : StopInformationRepository, stopInformation : [StopInformationModel?])
}

struct StopInformationRepository {
    let stopInfoURL = "https://api.mosgorpass.ru/v8.2/stop"
    
    var delegate : StopInformationRepositoryDelegate?
    
    func fetchStopInfo(stopID : String) {
        let urlString = "\(stopInfoURL)/\(stopID)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString : String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //TODO: delegate didFailWithError
                    return
                }
                if let safeData = data {
                    let stopDetails = parseJSON(safeData)
                    delegate?.didUpdateStopInfo(self, stopInformation: stopDetails)
                    //print(stopDetails)
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ stopDetails : Data) -> [StopInformationModel?] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try
            decoder.decode(StopInformationDTO.self, from: stopDetails)
            let detailsArray : [RoutePath] = decodedData.routePath
            return detailsArray.map({map(stopDetails: $0)})
            
        }
        catch {
            print("error")
            // TODO: ErrorExeption
            return [nil]
        }
    }
    
    
}
