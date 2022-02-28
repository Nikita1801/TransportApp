//
//  BottomSheetController.swift
//  TransportApp
//
//  Created by Никита Макаревич on 28.02.2022.
//

import UIKit

class BottomSheetController: UIViewController {
    
    @IBOutlet weak var transportInfoTableVIew: UITableView?

    var trasnportInfoArray : [StopInformationModel?] = []
    var stopInformationRepository = StopInformationRepository()
    var mapVC : MapViewController?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Текущие маршруты"
        transportInfoTableVIew?.delegate = self
        transportInfoTableVIew?.dataSource = self
        
        stopInformationRepository.delegate = self
        stopInformationRepository.fetchStopInfo(stopID: mapVC?.id ?? "00047fcc-66f3-4f9f-9c0e-8763091979cc")
        
        print("\(trasnportInfoArray)!!!!!!!!!!!!!!")

    }
    
    

}
extension BottomSheetController : StopInformationRepositoryDelegate {
    func didUpdateStopInfo(_ topInformationRepository: StopInformationRepository, stopInformation: [StopInformationModel?]) {
        print(stopInformation)
        self.trasnportInfoArray = stopInformation
        DispatchQueue.main.async {
            self.transportInfoTableVIew?.reloadData()
        }
        
    }
}

extension BottomSheetController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trasnportInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transportInfoTableVIew?.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let stopInfo = trasnportInfoArray[indexPath.row]
        cell.numberLable.text = stopInfo?.number
        cell.typeLable.text = stopInfo?.type
        cell.timeArrivalLable.text = stopInfo?.timeInterval.reduce("", { $0 == "" ? $1 : $0 + ", " + $1 })
        
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


