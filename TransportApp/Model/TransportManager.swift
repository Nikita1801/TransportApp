

import Foundation

protocol TransportManagerDelegate {
    func didUpdateBusStops(_ transportManager : TransportManager, stop : [StopModel?])
}

struct TransportManager {
    let transportURL = "https://api.mosgorpass.ru/v8.2/stop"
    
    var delegate : TransportManagerDelegate?
    
    
     func getBusStop() {
        let finalURL = transportURL
        if let url = URL(string: finalURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error ) in
                if error != nil {
                    print("Error")
                    return
                }
                if let safeData = data {
                    let transportInfo = parseJSON(safeData)
                    //print(transportInfo)
                    //print(self.parseJSON(safeData))
                    delegate?.didUpdateBusStops(self, stop: transportInfo)
                    
                    
                }
            }
            task.resume()
        }
            
    }
    
    func parseJSON(_ transportData : Data) -> [StopModel?] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TransportDataDTO.self, from: transportData)
            let stopArray :[StopDTO] = decodedData.data
            //print(stopArray.map{map(stop: $0)})
            return stopArray.map{map(stop: $0)}
        }
        catch{
            print("error")
            return [nil]
        }
    }
}


