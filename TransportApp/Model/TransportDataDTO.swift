
struct TransportDataDTO : Codable{
    let data : [StopDTO]
}

struct StopDTO : Codable {
    let id : String
    let lon : Double
    let lat : Double
    let name : String
}

