

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var stopsArray : [StopModel?] = []
    var stopsTableView = UITableView()
    var stopID : String = ""
    var stopLat : Double = 0.0
    var stopLon : Double = 0.0
    var stopName : String = ""
    let identifire = "MyCell"
    
    var transportManager = TransportManager()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Автобусные остановки"
        transportManager.delegate = self
        transportManager.getBusStops()
        
        
    }
    
    func createTable() {
        self.stopsTableView = UITableView(frame: view.bounds, style: .plain)
        stopsTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        self.stopsTableView.delegate = self
        self.stopsTableView.dataSource = self
        
        stopsTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stopsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stopsTableView)
        let horizontalConstraint = NSLayoutConstraint(item: stopsTableView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
            let verticalConstraint = NSLayoutConstraint(item: stopsTableView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
            let widthConstraint = NSLayoutConstraint(item: stopsTableView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 414)
            let heightConstraint = NSLayoutConstraint(item: stopsTableView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 800)
            view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMap") {
            let destinationVC = segue.destination as! MapViewController
            
            destinationVC.id = stopID
            destinationVC.lat = stopLat
            destinationVC.lon = stopLon
            destinationVC.name = stopName
        }
    }

    
    //MARK: - UITableViewDelegate
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        cell.accessoryType = .detailButton
        
        let stop = stopsArray[indexPath.row]
        cell.textLabel?.text = stop?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let stop = stopsArray[indexPath.row]
        stopID = stop?.id ?? ""
        stopLat = stop?.lat ?? 0.0
        stopLon = stop?.lon ?? 0.0
        stopName = stop?.name ?? ""
        
        self.performSegue(withIdentifier: "goToMap", sender: self)
    }

}
    
extension ViewController : TransportManagerDelegate{
    func didUpdateBusStops(_ transportManager: TransportManager, stop: [StopModel?]) {
        self.stopsArray = stop
        DispatchQueue.main.async {
            self.createTable()
        }
        
        
    }
}


