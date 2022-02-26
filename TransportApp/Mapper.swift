import Foundation

func map(stop : StopDTO) -> StopModel {
    return StopModel.init(id: stop.id, lat: stop.lat, lon: stop.lon, name: stop.name)
}
