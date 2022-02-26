

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var stopsArray : [StopModel?] = []
    var stopsTableView = UITableView()
    var stopID : String = ""
    let identifire = "MyCell"
    
    var transportManager = TransportManager()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        transportManager.delegate = self
        transportManager.getBusStop()
        
    }
    
    func createTable() {
        self.stopsTableView = UITableView(frame: view.bounds, style: .plain)
        stopsTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        self.stopsTableView.delegate = self
        self.stopsTableView.dataSource = self
        
        stopsTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(stopsTableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMap") {
            let destinationVC = segue.destination as! MapViewController
            
            destinationVC.id = stopID
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
        stopID = (stop?.id)!
        //print(stop ?? 0)
        self.performSegue(withIdentifier: "goToMap", sender: self)
        
        
        
            
    }

    
    
}
    
extension ViewController : TransportManagerDelegate{
    func didUpdateBusStops(_ transportManager: TransportManager, stop: [StopModel?]) {
        self.stopsArray = stop
        //print("______________!!!!!!!_____________")
        //print(stopsArray)
        DispatchQueue.main.async {
            self.createTable()
        }
        
        
    }
}


